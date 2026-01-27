import 'package:domain/auth/usecase/reset_password_usecase.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/auth/reset_password/state/reset_password_actions.dart';
import 'package:presentation/auth/reset_password/state/reset_password_events.dart';
import 'package:presentation/auth/reset_password/state/reset_password_state.dart';

@injectable
class ResetPasswordController extends GetxController {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordController(this.resetPasswordUseCase);

  ResetPasswordState _state = const ResetPasswordState();
  Rxn<ResetPasswordEvent> event = Rxn<ResetPasswordEvent>();

  ResetPasswordState get state => _state;

  void resetPasswordAction(ResetPasswordAction action) {
    if (action is SaveNewPassword) {
      _state = _state.copyWith(newPassword: action.password);
      update();
    } else if (action is SaveConfirmPassword) {
      _state = _state.copyWith(confirmPassword: action.password);
      update();
    } else if (action is SubmitResetPassword) {
      handleSubmit();
    }
  }

  Future<void> handleSubmit() async {
    try {
      _state = _state.copyWith(isLoading: true);
      update();

      await resetPasswordUseCase.call(_state.newPassword);

      _state = _state.copyWith(isLoading: false);
      update();

      event.value = ResetPasswordSuccessEvent();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      update();
      event.value = ResetPasswordErrorEvent(e.toString());
    }
  }
}
