part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  registrationSuccess,
  forgotPasswordSuccess,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? message;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? message,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        message,
        isPasswordVisible,
        isConfirmPasswordVisible,
      ];
}