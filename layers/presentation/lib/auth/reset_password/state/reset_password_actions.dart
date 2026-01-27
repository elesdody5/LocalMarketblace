abstract class ResetPasswordAction {}

class SaveNewPassword extends ResetPasswordAction {
  final String password;

  SaveNewPassword(this.password);
}

class SaveConfirmPassword extends ResetPasswordAction {
  final String password;

  SaveConfirmPassword(this.password);
}

class SubmitResetPassword extends ResetPasswordAction {}
