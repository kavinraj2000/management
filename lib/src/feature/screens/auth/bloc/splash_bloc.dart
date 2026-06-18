import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(const SplashState()) {
    on<SplashInitiated>(_onInitiated);
    on<SplashAnimationCompleted>(_onAnimationCompleted);
  }

  Future<void> _onInitiated(
    SplashInitiated event,
    Emitter<SplashState> emit,
  ) async {
    emit(
      state.copyWith(
        isAnimating: true,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(
      state.copyWith(
        isAnimating: false,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 600));

    emit(
      state.copyWith(
        shouldCheckAuth: true,
      ),
    );
  }

  Future<void> _onAnimationCompleted(
    SplashAnimationCompleted event,
    Emitter<SplashState> emit,
  ) async {
    emit(
      state.copyWith(
        shouldCheckAuth: false,
      ),
    );
  }
}
