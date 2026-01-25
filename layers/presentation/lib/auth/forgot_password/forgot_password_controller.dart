import 'package:get/get.dart';
import 'package:domain/auth/usecase/forgot_password_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/auth/forgot_password/state/forgot_password_events.dart';
import 'package:presentation/auth/forgot_password/state/forgot_password_state.dart';

import 'state/forgot_password_actions.dart';

@injectable
class ForgotPasswordController extends GetxController {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordController(this.forgotPasswordUseCase);

  ForgotPasswordState _state = ForgotPasswordState();
  Rxn<ForgotPasswordEvent> event = Rxn<ForgotPasswordEvent>();

  ForgotPasswordState get state => _state;

  void forgotPasswordAction(ForgotPasswordAction action) {
    if (action is SavePhone) {
      _state = _state.copyWith(phone: action.phone);
      update();
    } else if (action is SubmitForgotPassword) {
      handleSubmit();
    }
  }

  Future<void> handleSubmit() async {
    try {
      _state = _state.copyWith(isLoading: true);
      update();

      await forgotPasswordUseCase.call(_state.phone);

      _state = _state.copyWith(isLoading: false);
      update();

      event.value = ForgotPasswordSuccessEvent(_state.phone);
    } catch (e) {
      event.value = ForgotPasswordErrorEvent(e.toString());
      _state = _state.copyWith(isLoading: false);
      update();
    }
  }
}
