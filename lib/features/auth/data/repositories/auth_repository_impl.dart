import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/data/datasources/local/token_storage.dart';
import 'package:kursol/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:kursol/features/auth/data/mappers/api_response_data_mapper.dart';
import 'package:kursol/features/auth/data/mappers/otp_response_user_mapper.dart';
import 'package:kursol/features/auth/data/mappers/user_mapper.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';
import 'package:kursol/features/auth/domain/entities/otp_response_user_entity.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.tokenStorage}) {
    tokenStorage.init();
  }

  @override
  Future<Either<NetworkException, UserEntity>> registerWithPhone(
      String phoneNumber,
      String password,
      String firstName,
      String lastName) async {
    try {
      final userModel = await remoteDataSource.registerWithPhone(
          phoneNumber, password, firstName, lastName);

      final userEntity = userModel.toEntity();

      return Right(userEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, OtpVerifyResponseEntity>> verifyOtp(
      {required String otpCode, required String userId}) async {
    try {
      final responseModel =
          await remoteDataSource.verifyOtp(otpCode: otpCode, userId: userId);
      final responseEntity = OtpVerifyResponseEntity(
        success: responseModel.success,
        message: responseModel.message,
      );
      return Right(responseEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, ApiResponseDataEntity>> login(
      {required String username, required String password}) async {
    try {
      final responseModel =
          await remoteDataSource.login(username: username, password: password);

      await tokenStorage.saveTokens(
          responseModel.accessToken, responseModel.refreshToken);

      final responseEntity = responseModel.toEntity();
      return Right(responseEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, OtpVerifyResponseEntity>> resetPasswordOtp(
      {required String userId, required String otp}) async {
    try {
      final responseModel =
          await remoteDataSource.resetPasswordOtp(userId: userId, otp: otp);

      final responseEntity = OtpVerifyResponseEntity(
          success: responseModel.success,
          error: responseModel.error,
          message: responseModel.message,
          data: responseModel.data?.toEntity());

      return Right(responseEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, OtpVerifyResponseEntity>>
      resetPasswordViaPhone({required String phone}) async {
    try {
      final responseModel =
          await remoteDataSource.resetPasswordViaPhone(phone: phone);

      final responseEntity = OtpVerifyResponseEntity(
          success: responseModel.success, message: responseModel.message);
      return Right(responseEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, ApiResponseDataEntity>> refreshToken(
      {required String refreshToken}) async {
    try {
      final responseModel =
          await remoteDataSource.refreshToken(refreshToken: refreshToken);

      await tokenStorage.saveTokens(
          responseModel.accessToken, responseModel.refreshToken);

      final responseEntity = responseModel.toEntity();
      return Right(responseEntity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }
}
