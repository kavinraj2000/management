import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:tvkapp/src/data/domain/user_entity.dart';
import 'package:tvkapp/src/feature/auth/repo/auth_repo.dart';

=======
import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/feature/auth/repo/auth_repo.dart';
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository)
      : super(const AuthState()) {
    on<AuthCheckRequested>(_onCheckAuth);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthForgotPasswordRequested>(_onForgotPassword);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthTogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<AuthToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
  }

  Future<void> _onCheckAuth(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      if (_authRepository.isLoggedIn) {
        final user = await _authRepository.getCurrentUser();

        if (user != null) {
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              user: user,
              message: null,
            ),
          );
          return;
        }
      }

      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          message: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      final user = await _authRepository.register(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );

      emit(
        state.copyWith(
          status: AuthStatus.registrationSuccess,
          user: user,
          message: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onForgotPassword(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      await _authRepository.forgotPassword(
        event.email,
      );

      emit(
        state.copyWith(
          status: AuthStatus.forgotPasswordSuccess,
          message: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();

    emit(
      const AuthState(
        status: AuthStatus.unauthenticated,
      ),
    );
  }

  Future<void> _onTogglePasswordVisibility(
    AuthTogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
      ),
    );
  }

  Future<void> _onToggleConfirmPasswordVisibility(
    AuthToggleConfirmPasswordVisibility event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ),
    );
  }
}