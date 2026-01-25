abstract class ForgotPasswordAction {}

class SavePhone extends ForgotPasswordAction {
  final String phone;

  SavePhone(this.phone);
}

class SubmitForgotPassword extends ForgotPasswordAction {}
