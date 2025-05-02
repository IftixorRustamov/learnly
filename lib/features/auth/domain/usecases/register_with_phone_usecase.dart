import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class RegisterWithPhoneUseCase {
  final AuthRepository _authRepository;

  RegisterWithPhoneUseCase(this._authRepository);

  Future<Either<NetworkException, UserEntity>> call(
    String phoneNumber,
    String password,
    String firstName,
    String lastName,
  ) async {
    if (phoneNumber.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty) {
      throw Exception('All fields must be non-empty');
    }
    return await _authRepository.registerWithPhone(
      phoneNumber,
      password,
      firstName,
      lastName,
    );
  }
}
