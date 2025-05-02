import 'package:kursol/features/auth/data/models/user_model/user_model.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      username: username ?? phoneNumber,
      phoneNumber: phoneNumber,
      email: email,
      roles: roles,
      skillOccupation: skillOccupation,
      biography: biography,
      registrationDate: registrationDate,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      username: username,
      phoneNumber: phoneNumber,
      email: email,
      roles: roles,
      skillOccupation: skillOccupation,
      biography: biography,
      registrationDate: registrationDate,
    );
  }
}
