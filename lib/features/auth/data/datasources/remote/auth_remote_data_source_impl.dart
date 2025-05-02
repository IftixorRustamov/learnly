import 'package:dio/dio.dart';
import 'package:kursol/core/common/constants/api_urls.dart';
import 'package:kursol/core/network/dio_client.dart';
import 'package:kursol/features/auth/data/models/api_response_data/api_response_data_model.dart';
import 'package:kursol/features/auth/data/models/otp_verify_response_model.dart';
import 'package:kursol/features/auth/data/models/user_model/user_model.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> registerWithPhone(String phoneNumber, String password,
      String firstName, String lastName) async {
    try {
      final requestBody = {
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        "password": password
      };
      final response = await dioClient.post(
        ApiUrls.registerPhone,
        data: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['success'] == true && responseData['data'] != null) {
          return UserModel.fromJson(responseData['data']);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error:
                'Invalid response format: success is false or data is missing',
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<OtpVerifyResponseModel> verifyOtp(
      {required String otpCode, required String userId}) async {
    try {
      final requestBody = {
        'otp': otpCode,
        'userId': userId,
      };

      final response = await dioClient.post(ApiUrls.otp, data: requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        return OtpVerifyResponseModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Error verifying OTP',
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponseDataModel> login(
      {required String username, required String password}) async {
    try {
      final requestBody = {
        'username': username,
        'password': password,
      };

      final response = await dioClient.post(ApiUrls.login, data: requestBody);

      final data = response.data['data'];

      return ApiResponseDataModel.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<OtpVerifyResponseModel> resetPasswordViaPhone(
      {required String phone}) async {
    try {
      final response = await dioClient.post(
        ApiUrls.resetPasswordPhone,
        queryParameters: {"phone": phone},
      );

      final data = response.data;

      return OtpVerifyResponseModel.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponseDataModel> refreshToken(
      {required String refreshToken}) async {
    try {
      final response = await dioClient
          .post(ApiUrls.refreshToken, data: {"refreshToken": refreshToken});
      final data = response.data;
      return ApiResponseDataModel.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<OtpVerifyResponseModel> resetPasswordOtp(
      {required String userId, required String otp}) async {
    try {
      final requestBody = {
        'otp': otp,
        'userId': userId,
      };

      final response =
          await dioClient.post(ApiUrls.resetPasswordOtp, data: requestBody);

      return OtpVerifyResponseModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
