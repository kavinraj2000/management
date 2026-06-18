part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashInitiated extends SplashEvent {
  const SplashInitiated();
}

class SplashAnimationCompleted extends SplashEvent {
  const SplashAnimationCompleted();
}
