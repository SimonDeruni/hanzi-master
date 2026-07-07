import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

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
            _errorMessage = "You must accept the Terms of Service and Privacy Policy to create an account.";
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
        Navigator.pop(context); // Close auth screen on success
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          final errStr = e.toString();
          if (errStr.contains('CONFIGURATION_NOT_FOUND') || errStr.contains('FIRAuthErrorDomain')) {
            _errorMessage = "Firebase Auth not enabled. Please enable the required Sign-In method in your Firebase Console.";
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

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                  _isLogin ? "Welcome Back" : "Begin Your Journey",
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
                    label: "Name",
                    icon: Icons.person_outline,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                ],
                _buildTextField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  label: "Password",
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
                    onChanged: (val) => setState(() => _subscribeNewsletter = val ?? false),
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
                const SizedBox(height: 24),
                
                // --- OAuth Section ---
                Row(
                  children: [
                    Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 24),
                _buildOAuthButton(
                  isDark: isDark,
                  text: "Continue with Google",
                  iconPath: "assets/icon/google_logo.png", // Will default to a generic icon if missing
                  iconData: Icons.g_mobiledata,
                  onPressed: () => _handleOAuth(ref.read(authControllerProvider).signInWithGoogle),
                ),
                const SizedBox(height: 16),
                _buildOAuthButton(
                  isDark: isDark,
                  text: "Continue with Apple",
                  iconData: Icons.apple,
                  onPressed: () => _handleOAuth(ref.read(authControllerProvider).signInWithApple),
                ),
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
                        ? "Don't have an account? Sign up" 
                        : "Already have an account? Sign in",
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
                    _isLogin ? "Sign In" : "Create Account",
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

  Future<void> _handleOAuth(Future<void> Function() signInMethod) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await signInMethod();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildOAuthButton({
    required bool isDark,
    required String text,
    required VoidCallback onPressed,
    IconData? iconData,
    String? iconPath,
  }) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          side: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) ...[
              Icon(iconData, color: isDark ? Colors.white : Colors.black87, size: 28),
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
