// lib/domain/entities/user_entity.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? occupation;
  final String? location;
  final String? aboutMe;
  final int? age;
  final String? profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.occupation,
    this.location,
    this.aboutMe,
    this.age,
    this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? occupation,
    String? location,
    String? aboutMe,
    int? age,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      occupation: occupation ?? this.occupation,
      location: location ?? this.location,
      aboutMe: aboutMe ?? this.aboutMe,
      age: age ?? this.age,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, fullName, email, phone, occupation,
        location, aboutMe, age, profilePicture,
      ];
}

// lib/domain/entities/profile_entity.dart

class ProfileEntity extends Equatable {
  final String id;
  final String fullName;
  final String? email;
  final String? phone;
  final String? occupation;
  final String? location;
  final String? aboutMe;
  final int? age;
  final String? profilePicture;
  final String? gender;
  final bool isFavorite;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.occupation,
    this.location,
    this.aboutMe,
    this.age,
    this.profilePicture,
    this.gender,
    this.isFavorite = false,
  });

  ProfileEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? occupation,
    String? location,
    String? aboutMe,
    int? age,
    String? profilePicture,
    String? gender,
    bool? isFavorite,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      occupation: occupation ?? this.occupation,
      location: location ?? this.location,
      aboutMe: aboutMe ?? this.aboutMe,
      age: age ?? this.age,
      profilePicture: profilePicture ?? this.profilePicture,
      gender: gender ?? this.gender,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, fullName, email, isFavorite];
}