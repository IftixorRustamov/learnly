import 'package:kursol/features/auth/data/models/api_response_data/api_response_data_model.dart';
import 'package:kursol/features/auth/data/models/otp_verify_response_model.dart';
import 'package:kursol/features/auth/data/models/user_model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerWithPhone(
      String phoneNumber, String password, String firstName, String lastName);

  Future<OtpVerifyResponseModel> verifyOtp(
      {required String otpCode, required String userId});

  Future<ApiResponseDataModel> login(
      {required String username, required String password});

  Future<OtpVerifyResponseModel> resetPasswordViaPhone({required String phone});

  Future<OtpVerifyResponseModel> resetPasswordOtp(
      {required String userId, required String otp});

  Future<ApiResponseDataModel> refreshToken({required String refreshToken});
}
