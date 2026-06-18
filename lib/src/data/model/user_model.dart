

import 'package:profilediscovery/src/data/domain/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.phone,
    super.occupation,
    super.location,
    super.aboutMe,
    super.age,
    super.profilePicture,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      occupation: map['occupation'] as String?,
      location: map['location'] as String?,
      aboutMe: map['about_me'] as String?,
      age: map['age'] as int?,
      profilePicture: map['profile_picture'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      occupation: entity.occupation,
      location: entity.location,
      aboutMe: entity.aboutMe,
      age: entity.age,
      profilePicture: entity.profilePicture,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}


