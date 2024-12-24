import 'package:flutter1/services/auth/auth_provider.dart';
import 'package:flutter1/services/auth/auth_user.dart';

class AuthService implements AuthProviders {
  final AuthProviders providers;
  const AuthService(this.providers);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      providers.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => providers.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      providers.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => providers.logOut();

  @override
  Future<void> sendEmailVerification() => providers.sendEmailVerification();
}
