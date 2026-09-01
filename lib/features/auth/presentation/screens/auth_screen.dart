import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, this.requireSubscription = false});

  final bool requireSubscription;

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

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final controller = ref.read(authControllerProvider);
      if (_isLogin) {
        await controller.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        if (!_acceptTerms) {
          setState(() {
            _errorMessage = AppLocalizations.of(context)!.youMustAccount;
          });
          return;
        }
        await controller.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        );
      }
      await _completeAuthentication();
    } catch (e) {
      if (mounted) {
        setState(() {
          final errStr = e.toString();
          if (errStr.contains('CONFIGURATION_NOT_FOUND') ||
              errStr.contains('FIRAuthErrorDomain')) {
            _errorMessage = AppLocalizations.of(context)!.firebaseAuthConsole;
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

  Future<void> _completeAuthentication() async {
    if (!widget.requireSubscription) {
      if (mounted) Navigator.pop(context);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw StateError('Authentication did not return a user.');
    final isPremium = await MonetizationService.identifyUser(user.uid);
    if (!mounted) return;
    if (isPremium) {
      _enterSubscribedApp();
    } else {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.noActiveSubscriptionFound;
      });
    }
  }

  Future<void> _restoreSubscription() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final restored = await MonetizationService.restorePurchases();
      if (!mounted) return;
      if (restored) {
        _enterSubscribedApp();
      } else {
        setState(() => _errorMessage =
            AppLocalizations.of(context)!.noActiveSubscriptionFound);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage =
            AppLocalizations.of(context)!.noActiveSubscriptionFound);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _enterSubscribedApp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: !widget.requireSubscription,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
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
                      ? AppLocalizations.of(context)!.welcomeBack
                      : AppLocalizations.of(context)!.beginYourJourney,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Serif',
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin
                      ? "Sign in to sync your progress."
                      : "Create an account to save your stats.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                if (!_isLogin) ...[
                  _buildTextField(
                    controller: _nameController,
                    label: AppLocalizations.of(context)!.nameLabel,
                    icon: Icons.person_outline,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                ],
                _buildTextField(
                  controller: _emailController,
                  label: AppLocalizations.of(context)!.emailLabel,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  label: AppLocalizations.of(context)!.passwordLabel,
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
                    onChanged: (val) =>
                        setState(() => _acceptTerms = val ?? false),
                    title: Text(
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
                _buildSubmitButton(isDark),
                if (widget.requireSubscription) ...[
                  const SizedBox(height: 12),
                  TextButton.icon(
                    key: const Key('auth_restore_subscription'),
                    onPressed: _isLoading ? null : _restoreSubscription,
                    icon: const Icon(Icons.restore),
                    label: Text(AppLocalizations.of(context)!.restorePurchases),
                  ),
                  TextButton(
                    key: const Key('auth_view_subscription_plans'),
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => const CustomPaywallScreen(),
                              ),
                              (route) => false,
                            ),
                    child: const Text('View subscription plans'),
                  ),
                ],
                const SizedBox(height: 24),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _errorMessage = null;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? AppLocalizations.of(context)!.dontHaveAccountSignUp
                        : AppLocalizations.of(context)!
                            .alreadyHaveAccountSignIn,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    required bool isDark,
  }) {
    return TextField(
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

  Widget _buildSubmitButton(bool isDark) {
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
                        ? AppLocalizations.of(context)!.signIn
                        : AppLocalizations.of(context)!.createAccount,
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
