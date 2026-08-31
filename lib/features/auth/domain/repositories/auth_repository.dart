import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  bool get currentUserUsesPassword =>
      currentUser?.providerData.any((info) => info.providerId == 'password') ??
      false;

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(
      String email, String password, String name) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(name);
    return credential;
  }

  Future<void> signOut() async {
    try {
      if (await Hive.boxExists('character_chat_cache')) {
        final box = await Hive.openBox<String>('character_chat_cache');
        await box.clear();
      }
    } catch (_) {}
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  /// Permanently deletes the signed-in Firebase account after reauthentication.
  ///
  /// Device-only data is intentionally not touched. Apple authorization is
  /// revoked before deletion, as required by Sign in with Apple.
  Future<void> deleteAccount({String? password}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AccountDeletionException('no-user');
    }

    final providerIds =
        user.providerData.map((info) => info.providerId).toSet();

    if (providerIds.contains('apple.com')) {
      await _reauthenticateWithApple(user);
    } else if (providerIds.contains('google.com')) {
      await _reauthenticateWithGoogle(user);
    } else if (providerIds.contains('password')) {
      final email = user.email;
      if (email == null || password == null || password.isEmpty) {
        throw const AccountDeletionException('password-required');
      }
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } else {
      throw const AccountDeletionException('unsupported-provider');
    }

    await user.delete();

    if (providerIds.contains('google.com')) {
      try {
        await GoogleSignIn.instance.signOut();
      } catch (_) {
        // The Firebase account has already been deleted. A stale Google SDK
        // session must not turn a successful deletion into a reported failure.
      }
    }
  }

  Future<void> _reauthenticateWithGoogle(User user) async {
    await GoogleSignIn.instance.initialize();
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    await user.reauthenticateWithCredential(
      GoogleAuthProvider.credential(idToken: googleAuth.idToken),
    );
  }

  Future<void> _reauthenticateWithApple(User user) async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      throw const AccountDeletionException('apple-revocation-unavailable');
    }

    final rawNonce = _generateNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: const [AppleIDAuthorizationScopes.email],
      nonce: hashedNonce,
    );
    final identityToken = appleCredential.identityToken;
    if (identityToken == null) {
      throw const AccountDeletionException('apple-credential-missing');
    }

    final credential = OAuthProvider('apple.com').credential(
      idToken: identityToken,
      rawNonce: rawNonce,
    );
    await user.reauthenticateWithCredential(credential);
    await _auth.revokeTokenWithAuthorizationCode(
      appleCredential.authorizationCode,
    );
  }

  String _generateNonce([int length = 32]) {
    const characters =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => characters[random.nextInt(characters.length)],
    ).join();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    if (Platform.isIOS || Platform.isMacOS) {
      try {
        final AuthorizationCredentialAppleID appleCredential =
            await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final OAuthProvider oauthProvider = OAuthProvider('apple.com');
        final OAuthCredential credential = oauthProvider.credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        return await _auth.signInWithCredential(credential);
      } catch (e) {
        if (e is SignInWithAppleAuthorizationException &&
            e.code == AuthorizationErrorCode.canceled) {
          throw Exception('canceled');
        }
        rethrow;
      }
    } else {
      final appleProvider = AppleAuthProvider();
      return await _auth.signInWithProvider(appleProvider);
    }
  }
}

class AccountDeletionException implements Exception {
  final String code;

  const AccountDeletionException(this.code);

  @override
  String toString() => 'AccountDeletionException($code)';
}
