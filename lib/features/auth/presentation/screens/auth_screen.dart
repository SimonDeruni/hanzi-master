import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/main.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final bool requireSubscription;
  const AuthScreen({super.key, this.requireSubscription = false});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  String? _errorMessage;
  bool _acceptTerms = false;
  bool _subscribeNewsletter = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _restorePurchases() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final l10n = AppLocalizations.of(context);

    try {
      final isPremium = await MonetizationService.restorePurchases();
      if (isPremium && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
      } else {
        if (mounted) {
          ZenToast.error(
              context,
              l10n?.noActiveSubscriptionFound ??
                  "No active subscription found.");
        }
      }
    } catch (e) {
      debugPrint("Restore error: $e");
      if (mounted) {
        // Restoring talks to the store, which needs the network - and "no active
        // subscription found" is the wrong thing to tell someone in a tunnel.
        if (!NetworkNotice.showIfOffline(context, e)) {
          ZenToast.error(
              context,
              l10n?.noActiveSubscriptionFound ??
                  "No active subscription found.");
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _viewPlans() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CustomPaywallScreen()),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not launch $url: $e");
    }
  }

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await MonetizationService.lockDeveloperBackdoor();
      await ref.read(authControllerProvider).signOut();
    } catch (e) {
      debugPrint("Sign out error: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final l10n = AppLocalizations.of(context);
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    // App Review and the owner's account both bypass the paywall; the policy (which
    // addresses, which passwords) lives in `MonetizationService.compedAccounts` so a
    // second entry point cannot drift from this one.
    final isDemoAccount = MonetizationService.isCompedAccount(email, password);

    if (isDemoAccount) {
      await MonetizationService.unlockDeveloperBackdoor();
      try {
        ref.read(premiumControllerProvider.notifier).grantTemporaryAccess();
      } catch (_) {}

      try {
        final controller = ref.read(authControllerProvider);
        await controller.signIn(email, password);
      } catch (_) {
        try {
          final controller = ref.read(authControllerProvider);
          // Creates the account on its first use, under the name the table carries —
          // the address is not registered in Firebase until someone signs in with it.
          await controller.signUp(
              email, password, MonetizationService.compedAccountName(email));
        } catch (_) {
          try {
            await FirebaseAuth.instance.signInAnonymously();
          } catch (_) {}
        }
      }

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const AppStartupFlow(),
          ),
          (route) => false,
        );
      }
      return;
    }

    // A comped grant belongs to the account that earned it, not to the device: the
    // unlock is persisted in prefs, so someone signing in as a different account
    // afterwards must not inherit it. A paying user is unaffected — their entitlement
    // comes from RevenueCat whatever this flag says.
    await MonetizationService.lockDeveloperBackdoor();

    try {
      final controller = ref.read(authControllerProvider);
      if (_isLogin) {
        await controller.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        if (!_acceptTerms) {
          HapticsManager.error();
          setState(() {
            _errorMessage = l10n?.youMustAccount ??
                "You must accept the Terms of Service and Privacy Policy to create an account.";
          });
          return;
        }
        await controller.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        );
      }
      if (mounted) {
        if (widget.requireSubscription) {
          final isPremium = await MonetizationService.checkPremiumStatus();
          if (mounted) {
            if (isPremium) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CustomPaywallScreen()),
              );
            }
          }
        } else {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen()),
              (route) => false,
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      // One refusal for every credential rejection the switch below maps, rather
      // than one per case: a wrong password and a locked account are the same
      // "no" to the person holding the phone.
      HapticsManager.error();
      if (mounted) {
        setState(() {
          // A transport-level failure of any kind — not only firebase_auth's own
          // `network-request-failed` code — is the same problem for the learner,
          // so it is asked once here instead of being enumerated in the switch.
          if (NetworkFailure.isOffline(e)) {
            _errorMessage = l10n?.authNetworkError ??
                "Network error. Please check your connection.";
            return;
          }
          switch (e.code) {
            case 'invalid-credential':
            case 'user-not-found':
            case 'wrong-password':
              _errorMessage = l10n?.authInvalidCredentials ??
                  "Incorrect email or password. If you do not have an account, please sign up.";
              break;
            case 'invalid-email':
              _errorMessage = l10n?.authInvalidEmail ??
                  "Please enter a valid email address.";
              break;
            case 'email-already-in-use':
              _errorMessage = l10n?.authEmailAlreadyInUse ??
                  "An account already exists with this email address.";
              break;
            case 'weak-password':
              _errorMessage = l10n?.authWeakPassword ??
                  "Password must be at least 6 characters.";
              break;
            case 'too-many-requests':
              _errorMessage = l10n?.authTooManyRequests ??
                  "Too many failed attempts. Please try again later.";
              break;
            default:
              final errStr = e.message ?? e.toString();
              if (errStr.contains('CONFIGURATION_NOT_FOUND') ||
                  errStr.contains('FIRAuthErrorDomain')) {
                _errorMessage = l10n?.firebaseAuthConsole ??
                    "Firebase Auth not enabled. Please enable the required Sign-In method in your Firebase Console.";
              } else if (errStr.contains('malformed or has expired') ||
                  errStr.contains('invalid-credential')) {
                _errorMessage = l10n?.authInvalidCredentials ??
                    "Incorrect email or password. If you do not have an account, please sign up.";
              } else {
                _errorMessage =
                    errStr.replaceAll(RegExp(r'\[.*?\]'), '').trim();
              }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          final errStr = e.toString();
          if (errStr.contains('CONFIGURATION_NOT_FOUND') ||
              errStr.contains('FIRAuthErrorDomain')) {
            _errorMessage = l10n?.firebaseAuthConsole ??
                "Firebase Auth not enabled. Please enable the required Sign-In method in your Firebase Console.";
          } else if (errStr.contains('malformed or has expired') ||
              errStr.contains('invalid-credential') ||
              errStr.contains('user-not-found') ||
              errStr.contains('wrong-password')) {
            _errorMessage = l10n?.authInvalidCredentials ??
                "Incorrect email or password. If you do not have an account, please sign up.";
          } else {
            _errorMessage = errStr.replaceAll(RegExp(r'\[.*?\]'), '').trim();
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    User? currentUser;
    try {
      currentUser = ref.watch(currentUserProvider);
    } catch (_) {}
    if (currentUser == null) {
      try {
        currentUser = FirebaseAuth.instance.currentUser;
      } catch (_) {}
    }
    final isAccountGatekeeper =
        widget.requireSubscription && currentUser != null;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        actions: isAccountGatekeeper
            ? [
                TextButton.icon(
                  key: const Key('auth_gatekeeper_sign_out_appbar'),
                  onPressed: _isLoading ? null : _signOut,
                  icon: Icon(
                    Icons.logout,
                    size: 18,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  label: Text(
                    l10n?.signOut ?? "Sign Out",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ]
            : null,
      ),
      body: ZenFadeIn(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: isAccountGatekeeper
                  ? _buildAccountGatekeeperView(
                      context,
                      isDark,
                      l10n,
                      currentUser,
                    )
                  : _buildAuthForm(context, isDark, l10n),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountGatekeeperView(
    BuildContext context,
    bool isDark,
    AppLocalizations? l10n,
    User currentUser,
  ) {
    final theme = Theme.of(context);
    final email = currentUser.email ?? currentUser.displayName ?? "";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white10
                  : const Color(0xFF1A1A1B).withValues(alpha: 0.05),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.workspace_premium_outlined,
                size: 46,
                color: Color(0xFFD4AF37),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          l10n?.subscriptionRequired ?? "Subscription Required",
          key: const Key('auth_gatekeeper_title'),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        if (email.isNotEmpty) ...[
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n?.signedInAs(email) ?? "Signed in as $email",
                    key: const Key('auth_gatekeeper_user_email'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Text(
              l10n?.noActiveSubscriptionFound ??
                  "No active subscription found.",
              key: const Key('auth_gatekeeper_status_badge'),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFB8860B),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n?.subscriptionRequiredDesc ??
              "An active SinoSpark membership is required to access all lessons, books, and AI speech tools.",
          key: const Key('auth_gatekeeper_desc'),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.white70 : Colors.black54,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 36),
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [Color(0xFF6750A4), Color(0xFF381E72)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6750A4).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              key: const Key('auth_gatekeeper_view_plans_button'),
              borderRadius: BorderRadius.circular(28),
              onTap: _isLoading ? null : _viewPlans,
              child: Center(
                child: Text(
                  l10n?.viewPlans ?? "View Plans",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          key: const Key('auth_gatekeeper_restore_button'),
          onPressed: _isLoading ? null : _restorePurchases,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            side: BorderSide(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  l10n?.restore ?? "Restore Purchases",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        const SizedBox(height: 12),
        TextButton(
          key: const Key('auth_gatekeeper_sign_out_button'),
          onPressed: _isLoading ? null : _signOut,
          child: Text(
            l10n?.signOut ?? "Sign Out",
            style: TextStyle(
              color: isDark ? Colors.white60 : Colors.black54,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLegalLinks(isDark, l10n),
      ],
    );
  }

  Widget _buildLegalLinks(bool isDark, AppLocalizations? l10n) {
    final linkStyle = TextStyle(
      color: isDark ? Colors.white54 : Colors.black45,
      fontSize: 11.5,
      decoration: TextDecoration.underline,
    );

    final termsText = l10n?.termsOfUseEula ?? "Terms of Use (EULA)";
    final privacyText = l10n?.privacyPolicy ?? "Privacy Policy";

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 4,
      children: [
        TextButton(
          key: const Key('auth_terms_button'),
          onPressed: () => _launchURL('https://sinospark.app/terms.html'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            termsText,
            style: linkStyle,
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          key: const Key('auth_privacy_button'),
          onPressed: () => _launchURL('https://sinospark.app/privacy.html'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            privacyText,
            style: linkStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthForm(
    BuildContext context,
    bool isDark,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.auto_awesome,
          size: 64,
          color: isDark ? Colors.white : Colors.black87,
        ),
        const SizedBox(height: 32),
        Text(
          _isLogin
              ? (l10n?.welcomeBack ?? "Welcome Back")
              : (l10n?.beginYourJourney ?? "Begin Your Journey"),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _isLogin
              ? (l10n?.signInToSyncYourProgress ??
                  "Sign in to sync your progress.")
              : (l10n?.createAnAccountToSaveYourStats ??
                  "Create an account to save your stats."),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 48),
        if (!_isLogin) ...[
          _buildTextField(
            key: const Key('auth_name_field'),
            controller: _nameController,
            label: l10n?.nameLabel ?? "Name",
            icon: Icons.person_outline,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
        ],
        _buildTextField(
          key: const Key('auth_email_field'),
          controller: _emailController,
          label: l10n?.emailLabel ?? "Email",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          key: const Key('auth_password_field'),
          controller: _passwordController,
          label: l10n?.passwordLabel ?? "Password",
          icon: Icons.lock_outline,
          obscureText: true,
          isDark: isDark,
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: TextStyle(color: Colors.red.shade400, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
        if (!_isLogin) ...[
          const SizedBox(height: 24),
          CheckboxListTile(
            value: _acceptTerms,
            onChanged: (val) => setState(() => _acceptTerms = val ?? false),
            title: Text(
              l10n?.iAgreeToTheTermsOfServiceAndPrivacy ??
                  "I agree to the Terms of Service and Privacy Policy.",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 13,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF6750A4),
            dense: true,
          ),
          CheckboxListTile(
            value: _subscribeNewsletter,
            onChanged: (val) =>
                setState(() => _subscribeNewsletter = val ?? false),
            title: Text(
              l10n?.sendMeOccasionalUpdatesTipsAndOffer ??
                  "Send me occasional updates, tips, and offers.",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 13,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF6750A4),
            dense: true,
          ),
        ],
        const SizedBox(height: 32),
        _buildSubmitButton(isDark, l10n),
        const SizedBox(height: 24),
        if (widget.requireSubscription) ...[
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 2,
            children: [
              TextButton(
                key: const Key('auth_restore_subscription'),
                onPressed: _isLoading ? null : _restorePurchases,
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n?.restore ?? "Restore Purchases",
                  style: TextStyle(
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ),
              Text("•",
                  style: TextStyle(
                      color: isDark ? Colors.white30 : Colors.black26)),
              TextButton(
                key: const Key('auth_view_subscription_plans'),
                onPressed: _isLoading ? null : _viewPlans,
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n?.viewPlans ?? "View Plans",
                  style: TextStyle(
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              _isLogin = !_isLogin;
              _errorMessage = null;
            });
          },
          child: Text(
            _isLogin
                ? (l10n?.dontHaveAccountSignUp ??
                    "Don't have an account? Sign up")
                : (l10n?.alreadyHaveAccountSignIn ??
                    "Already have an account? Sign in"),
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildLegalLinks(isDark, l10n),
      ],
    );
  }

  Widget _buildTextField({
    Key? key,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    required bool isDark,
  }) {
    return TextField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
        prefixIcon: Icon(icon, color: isDark ? Colors.white54 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.grey.shade900 : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6750A4), width: 2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isDark, AppLocalizations? l10n) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF6750A4), Color(0xFF381E72)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6750A4).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key('auth_submit_button'),
          borderRadius: BorderRadius.circular(28),
          onTap: _isLoading ? null : _submit,
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _isLogin
                        ? (l10n?.signIn ?? "Sign In")
                        : (l10n?.createAccount ?? "Create Account"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
