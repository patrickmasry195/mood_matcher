class AuthSupaState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  AuthSupaState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AuthSupaState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthSupaState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
