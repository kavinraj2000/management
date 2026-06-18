import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvkapp/src/data/domain/user_entity.dart';
import 'package:tvkapp/src/feature/auth/repo/auth_repo.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;

  ProfileBloc(this._authRepository)
      : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoad);
    on<ProfileUpdateRequested>(_onUpdate);
    on<ProfilePictureUpdateRequested>(_onPictureUpdate);
  }

  Future<void> _onLoad(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProfileStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final user =
          await _authRepository.getCurrentUser();

      if (user == null) {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'User not found',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: user,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdate(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;

    emit(
      state.copyWith(
        status: ProfileStatus.updating,
      ),
    );

    try {
      final updatedUser =
          await _authRepository.updateProfile(
        userId: state.user!.id,
        data: {
          'full_name': event.fullName,
          'age': event.age,
          'phone': event.phone,
          'occupation': event.occupation,
          'location': event.location,
          'about_me': event.aboutMe,
        },
      );

      emit(
        state.copyWith(
          status: ProfileStatus.updateSuccess,
          user: updatedUser,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPictureUpdate(
    ProfilePictureUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.user == null) return;

    emit(
      state.copyWith(
        status: ProfileStatus.imageUploading,
      ),
    );

    try {
      final updatedUser =
          await _authRepository.updateProfile(
        userId: state.user!.id,
        data: {
          'profile_picture': event.imagePath,
        },
      );

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: updatedUser,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}