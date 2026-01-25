abstract class ForgotPasswordEvent {}

class ForgotPasswordSuccessEvent extends ForgotPasswordEvent {
  final String phone;

  ForgotPasswordSuccessEvent(this.phone);
}

class ForgotPasswordErrorEvent extends ForgotPasswordEvent {
  final String message;

  ForgotPasswordErrorEvent(this.message);
}
