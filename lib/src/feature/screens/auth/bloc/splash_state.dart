part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool isAnimating;
  final bool shouldCheckAuth;

  const SplashState({
    this.isAnimating = false,
    this.shouldCheckAuth = false,
  });

  SplashState copyWith({
    bool? isAnimating,
    bool? shouldCheckAuth,
  }) {
    return SplashState(
      isAnimating: isAnimating ?? this.isAnimating,
      shouldCheckAuth: shouldCheckAuth ?? this.shouldCheckAuth,
    );
  }

  @override
  List<Object?> get props => [
        isAnimating,
        shouldCheckAuth,
      ];
}
