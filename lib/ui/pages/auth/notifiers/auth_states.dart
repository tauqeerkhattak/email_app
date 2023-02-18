abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class RegisteredAuthState extends AuthState {}

class LoginAuthState extends AuthState {}

class LogoutAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  String error;

  ErrorAuthState(this.error);
}
