abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String userEmail;
  final String userPassword;

  LoginEvent({required this.userEmail, required this.userPassword});

}

class RegisterEvent extends AuthEvent {
  final String userEmail;
  final String userPassword;

  RegisterEvent({required this.userEmail, required this.userPassword});
}
