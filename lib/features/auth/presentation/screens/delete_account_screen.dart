import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/auth/domain/repositories/auth_repository.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

typedef AccountDeletionCallback = Future<void> Function(String? password);

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({
    super.key,
    required this.usesPassword,
    this.onDelete,
  });

  final bool usesPassword;
  final AccountDeletionCallback? onDelete;

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  static final Uri _subscriptionsUri =
      Uri.parse('https://apps.apple.com/account/subscriptions');

  final _passwordController = TextEditingController();
  bool _isDeleting = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _manageSubscription() async {
    final launched = await launchUrl(
      _subscriptionsUri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && mounted) {
      setState(() {
        _errorMessage =
            AppLocalizations.of(context)!.subscriptionManagementFailed;
      });
    }
  }

  Future<void> _confirmDeletion() async {
    final l10n = AppLocalizations.of(context)!;
    if (widget.usesPassword && _passwordController.text.isEmpty) {
      setState(() => _errorMessage = l10n.accountPasswordRequired);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteAccountFinalTitle),
        content: Text(l10n.deleteAccountFinalWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.deleteAccountPermanently),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _isDeleting = true;
      _errorMessage = null;
    });

    try {
      final delete = widget.onDelete ??
          (password) => ref
              .read(authControllerProvider)
              .deleteAccount(password: password);
      await delete(widget.usesPassword ? _passwordController.text : null);
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isDeleting = false;
        _errorMessage = _messageFor(error, l10n);
      });
    }
  }

  String _messageFor(Object error, AppLocalizations l10n) {
    if (error is SignInWithAppleAuthorizationException &&
        error.code == AuthorizationErrorCode.canceled) {
      return l10n.accountReauthenticationCanceled;
    }
    if (error is AccountDeletionException) {
      switch (error.code) {
        case 'password-required':
          return l10n.accountPasswordRequired;
        case 'no-user':
          return l10n.accountAlreadySignedOut;
        case 'unsupported-provider':
          return l10n.accountProviderUnsupported;
        case 'apple-revocation-unavailable':
          return l10n.appleDeletionRequiresAppleDevice;
        case 'apple-credential-missing':
          return l10n.accountReauthenticationFailed;
      }
    }
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'wrong-password':
        case 'invalid-credential':
          return l10n.accountPasswordIncorrect;
        case 'network-request-failed':
          return l10n.accountDeletionNetworkError;
        case 'requires-recent-login':
        case 'user-mismatch':
          return l10n.accountReauthenticationFailed;
      }
    }
    if (error.toString().contains('canceled')) {
      return l10n.accountReauthenticationCanceled;
    }
    return l10n.accountDeletionFailed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_isDeleting,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.deleteAccount)),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Icon(Icons.delete_forever_outlined,
                size: 64, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              l10n.deleteAccountTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _InformationCard(
              icon: Icons.cloud_off_outlined,
              title: l10n.accountDataDeletedTitle,
              body: l10n.accountDataDeletedBody,
            ),
            const SizedBox(height: 12),
            _InformationCard(
              icon: Icons.phone_iphone,
              title: l10n.localDataKeptTitle,
              body: l10n.localDataKeptBody,
            ),
            const SizedBox(height: 12),
            _InformationCard(
              icon: Icons.workspace_premium_outlined,
              title: l10n.subscriptionNotCanceledTitle,
              body: l10n.subscriptionNotCanceledBody,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _isDeleting ? null : _manageSubscription,
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.manageSubscription),
              ),
            ),
            if (widget.usesPassword) ...[
              const SizedBox(height: 16),
              TextField(
                key: const Key('delete-account-password'),
                controller: _passwordController,
                enabled: !_isDeleting,
                obscureText: _obscurePassword,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: l10n.confirmPassword,
                  helperText: l10n.confirmPasswordToDelete,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Semantics(
                liveRegion: true,
                child: Text(
                  _errorMessage!,
                  key: const Key('delete-account-error'),
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton.icon(
              key: const Key('delete-account-submit'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _isDeleting ? null : _confirmDeletion,
              icon: _isDeleting
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.delete_forever),
              label: Text(_isDeleting
                  ? l10n.deletingAccount
                  : l10n.deleteAccountPermanently),
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(body),
        ),
      ),
    );
  }
}
