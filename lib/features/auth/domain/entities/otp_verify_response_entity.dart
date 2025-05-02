import 'package:kursol/features/auth/domain/entities/api_response_error_entity.dart';
import 'package:kursol/features/auth/domain/entities/otp_response_user_entity.dart';

class OtpVerifyResponseEntity {
  final bool success;
  final String? message;
  final OtpResponseUserEntity? data;
  final ApiResponseErrorEntity? error;

  const OtpVerifyResponseEntity({
    required this.success,
    this.message,
    this.data,
    this.error,
  });
}
