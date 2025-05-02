import 'package:json_annotation/json_annotation.dart';
import 'package:kursol/features/auth/data/models/api_response_error/api_response_error.dart';
import 'package:kursol/features/auth/data/models/otp_response_user/otp_response_user_model.dart';

part 'otp_verify_response_model.g.dart';

@JsonSerializable()
class OtpVerifyResponseModel {
  final bool success;
  final String? message;
  final OtpResponseUserModel? data;
  final ApiResponseErrorModel? error;

  const OtpVerifyResponseModel({
    required this.success,
    this.message,
    this.data,
    this.error,
  });

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseModelFromJson(json);
}
