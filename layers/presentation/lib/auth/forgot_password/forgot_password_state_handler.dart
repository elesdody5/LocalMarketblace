import 'package:get/get.dart';
import 'package:presentation/auth/forgot_password/state/forgot_password_events.dart';
import 'package:presentation/routes/auth_routes.dart';
import 'package:presentation/widgets/error_snackbar.dart';

void observeForgotPasswordEvents(Rxn<ForgotPasswordEvent> event) {
  ever(event, (ForgotPasswordEvent? currentEvent) {
    if (currentEvent is ForgotPasswordSuccessEvent) {
      // Navigate to verification screen with phone argument
      Get.toNamed(
        verificationRouteName,
        arguments: {verificationPhoneArg: currentEvent.phone},
      );
    } else if (currentEvent is ForgotPasswordErrorEvent) {
      ErrorSnackbar.showValidationError(message: currentEvent.message);
    }
  });
}
