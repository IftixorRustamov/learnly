import 'package:dartz/dartz.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //? (POST /v1/auth/register/phone)
  Future<Either<NetworkException, UserEntity>> registerWithPhone(
    String phoneNumber,
    String password,
    String firstName,
    String lastName,
  );

//? (POST /v1/auth/otp-verification)
  Future<Either<NetworkException, OtpVerifyResponseEntity>> verifyOtp(
      {required String otpCode, required String userId});

//? (POST /v1/auth/login)
  Future<Either<NetworkException, ApiResponseDataEntity>> login(
      {required String username, required String password});

//? (POST//v1/auth/reset-password-otp-verification)
  Future<Either<NetworkException, OtpVerifyResponseEntity>>
      resetPasswordOtp({required String userId, required String otp});

//? (POST /v1/auth/reset-password/phone)
  Future<Either<NetworkException, OtpVerifyResponseEntity>>
      resetPasswordViaPhone({required String phone});

//? (POST /v1/auth/refresh-token)
  Future<Either<NetworkException, ApiResponseDataEntity>> refreshToken(
      {required String refreshToken});

// //? (PUT /v1/auth/reset-password)
// Future<void> resetPassword(
//   String otpCode,
//   List<String> newPassword,
//   List<String> confirmPassword,
// );
//

// //? (POST /v1/auth/logout)
// Future<ApiResponse<void>> logout();
//

// //? (GET /v1/auth/grant-code)
// Future<ApiResponse<ApiResponseDataEntity>> getGrantCode(String grantCode);
//
// UserEntity? getCurrentUser();
//
// bool isUserLoggedIn();
}
