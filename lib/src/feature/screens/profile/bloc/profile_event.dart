<<<<<<< HEAD
=======
// lib/presentation/blocs/profile/profile_event.dart

>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileUpdateRequested extends ProfileEvent {
  final String fullName;
  final int age;
  final String phone;
  final String occupation;
  final String location;
  final String aboutMe;

<<<<<<< HEAD
  const ProfileUpdateRequested({
=======
  const ProfileUpdateRequested(Map<String, dynamic> data, {
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    required this.fullName,
    required this.age,
    required this.phone,
    required this.occupation,
    required this.location,
    required this.aboutMe,
  });

  @override
  List<Object?> get props => [
        fullName,
        age,
        phone,
        occupation,
        location,
        aboutMe,
      ];
}

class ProfilePictureUpdateRequested extends ProfileEvent {
  final String imagePath;

  const ProfilePictureUpdateRequested(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
<<<<<<< HEAD
}
=======
}

>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
