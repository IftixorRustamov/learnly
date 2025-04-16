import 'package:kursol/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.email,
      required super.firstName,
      required super.lastName,
      required super.username,
      required super.roles,
      required super.skillOccupation,
      required super.registrationDate,
      String? phoneNumber,
      String? biography});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      roles: List<String>.from(json['roles'] as List),
      skillOccupation: json['skill_occupation'] as bool,
      biography: json['biography'] as String?,
      registrationDate: DateTime.parse(json['registration_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'roles': roles,
      'skill_occupation': skillOccupation,
      'biography': biography,
      'registration_date': registrationDate.toIso8601String(),
    };
  }
}
