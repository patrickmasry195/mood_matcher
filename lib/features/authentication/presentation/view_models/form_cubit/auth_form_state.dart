class AuthFormState {
  final String name;
  final String email;
  final String phone;
  final String password;

  final bool isNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;

  bool get isFormValid =>
      isNameValid && isEmailValid && isPhoneValid && isPasswordValid;

  AuthFormState({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.isNameValid,
    required this.isEmailValid,
    required this.isPhoneValid,
    required this.isPasswordValid,
  });

  factory AuthFormState.initial() => AuthFormState(
        name: '',
        email: '',
        phone: '',
        password: '',
        isNameValid: false,
        isEmailValid: false,
        isPhoneValid: false,
        isPasswordValid: false,
      );

  AuthFormState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    bool? isNameValid,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
  }) {
    return AuthFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }
}
