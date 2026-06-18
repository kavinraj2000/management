

import 'package:profilediscovery/src/data/domain/user_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.fullName,
    super.email,
    super.phone,
    super.occupation,
    super.location,
    super.aboutMe,
    super.age,
    super.profilePicture,
    super.gender,
    super.isFavorite,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      occupation: map['occupation'] as String?,
      location: map['location'] as String?,
      aboutMe: map['about_me'] as String?,
      age: map['age'] as int?,
      profilePicture: map['profile_picture'] as String?,
      gender: map['gender'] as String?,
      isFavorite: (map['is_favorite'] as int? ?? 0) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'occupation': occupation,
      'location': location,
      'about_me': aboutMe,
      'age': age,
      'profile_picture': profilePicture,
      'gender': gender,
      'is_favorite': isFavorite ? 1 : 0,
      'cached_at': DateTime.now().toIso8601String(),
    };
  }
}