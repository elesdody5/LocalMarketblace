class ForgotPasswordState {
  final String phone;
  final bool isLoading;

  ForgotPasswordState({
    this.phone = '',
    this.isLoading = false,
  });

  ForgotPasswordState copyWith({
    String? phone,
    bool? isLoading,
  }) {
    return ForgotPasswordState(
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
