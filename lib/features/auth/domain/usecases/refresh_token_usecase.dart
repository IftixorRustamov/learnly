import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _authRepository;

  RefreshTokenUseCase(this._authRepository);

  Future<Either<NetworkException, ApiResponseDataEntity>> call(
      String refreshToken) async {
    return await _authRepository.refreshToken(refreshToken: refreshToken);
  }
}
