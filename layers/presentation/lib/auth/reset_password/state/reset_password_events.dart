sealed class ResetPasswordEvent {}

class ResetPasswordSuccessEvent extends ResetPasswordEvent {}

class ResetPasswordErrorEvent extends ResetPasswordEvent {
  final String message;

  ResetPasswordErrorEvent(this.message);
}
