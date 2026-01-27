import 'package:get/get.dart';
import 'package:presentation/auth/reset_password/state/reset_password_events.dart';
import 'package:presentation/routes/auth_routes.dart';
import 'package:presentation/widgets/error_snackbar.dart';

void observeResetPasswordEvents(Rxn<ResetPasswordEvent> event) {
  ever(event, (ResetPasswordEvent? currentEvent) {
    if (currentEvent is ResetPasswordSuccessEvent) {
      // Go to login and clear stack
      Get.offAllNamed(loginRouteName);
    } else if (currentEvent is ResetPasswordErrorEvent) {
      ErrorSnackbar.showValidationError(message: currentEvent.message);
    }
  });
}
