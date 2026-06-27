import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/auth/domain/repositories/auth_repository.dart';

// Stream provider to instantly react to auth changes
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

// Provides the current user directly
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).valueOrNull;
});

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});

class AuthController {
  final AuthRepository _repository;

  AuthController(this._repository);

  Future<void> signIn(String email, String password) async {
    await _repository.signIn(email, password);
  }

  Future<void> signUp(String email, String password, String name) async {
    await _repository.signUp(email, password, name);
  }

  Future<void> signInWithGoogle() async {
    await _repository.signInWithGoogle();
  }

  Future<void> signInWithApple() async {
    await _repository.signInWithApple();
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}
