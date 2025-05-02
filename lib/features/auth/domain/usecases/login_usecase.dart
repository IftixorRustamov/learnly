import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  Future<Either<NetworkException, ApiResponseDataEntity>> call(
      {required String username, required String password}) async {
    return await _authRepository.login(username: username, password: password);
  }
}
