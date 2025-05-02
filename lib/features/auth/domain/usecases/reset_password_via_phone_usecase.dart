import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/api_response_entity.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';

import '../repositories/auth_repository.dart';

class ResetPasswordViaPhoneUsecase {
  final AuthRepository _authRepository;

  ResetPasswordViaPhoneUsecase(this._authRepository);

  Future<Either<NetworkException, OtpVerifyResponseEntity>>
      resetPasswordViaPhone({required String phone}) async {
    return await _authRepository.resetPasswordViaPhone(phone: phone);
  }
}
