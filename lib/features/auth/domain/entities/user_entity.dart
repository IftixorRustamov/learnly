import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? username;
  final String? email;
  final String phoneNumber;
  final List<String>? roles;
  final bool? skillOccupation;
  final String? biography;
  final DateTime? registrationDate;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.username,
    this.email,
    this.roles,
    this.skillOccupation,
    this.biography,
    this.registrationDate,
  });

  // 👑 copyWith method
  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    List<String>? roles,
    bool? skillOccupation,
    String? biography,
    DateTime? registrationDate,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      roles: roles ?? this.roles,
      skillOccupation: skillOccupation ?? this.skillOccupation,
      biography: biography ?? this.biography,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  // 📦 Equatable override
  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        username,
        email,
        phoneNumber,
        roles,
        skillOccupation,
        biography,
        registrationDate,
      ];
}
