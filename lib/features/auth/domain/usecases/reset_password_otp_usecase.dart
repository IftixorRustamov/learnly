import 'package:dartz/dartz.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/exceptions/network/network_exception.dart';
import '../entities/otp_verify_response_entity.dart';

class ResetPasswordOtpUsecase {
  final AuthRepository _authRepository;

  ResetPasswordOtpUsecase(this._authRepository);

  Future<Either<NetworkException, OtpVerifyResponseEntity>> resetPasswordOtp(
          {required String userId, required String otp}) async =>
      _authRepository.resetPasswordOtp(userId: userId, otp: otp);
}
