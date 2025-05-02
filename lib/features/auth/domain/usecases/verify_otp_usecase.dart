import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _authRepository;

  const VerifyOtpUseCase(this._authRepository);

  Future<Either<NetworkException, OtpVerifyResponseEntity>> verifyOtp(
      {required String otpCode, required String userId}) async {
    return await _authRepository.verifyOtp(otpCode: otpCode, userId: userId);
  }
}
