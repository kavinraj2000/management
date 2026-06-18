part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  updating,
  updateSuccess,
  imageUploading,
  failure,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        errorMessage,
      ];
}