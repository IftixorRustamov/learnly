import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
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

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
