class ResetPasswordState {
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;

  const ResetPasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
  });

  bool get isValid => newPassword.length >= 8 && newPassword == confirmPassword;

  ResetPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
