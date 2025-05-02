import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kursol/core/network/model/error_model.dart';

class NetworkException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  NetworkException.fromDioError(DioException dioException)
      : this._fromDioError(dioException);

  const NetworkException.custom({required this.message, this.statusCode})
      : assert(statusCode == null || statusCode >= 400);

  NetworkException._fromDioError(DioException dioException)
      : statusCode = dioException.response?.statusCode,
        message = _parseDioError(dioException);

  static String _parseDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return "Request to API server was cancelled";

      case DioExceptionType.connectionTimeout:
        return "Connection timeout with API server";

      case DioExceptionType.receiveTimeout:
        return "Receive timeout in connection with API server";

      case DioExceptionType.sendTimeout:
        return "Send timeout in connection with API server";

      case DioExceptionType.connectionError:
        if (dioException.error.runtimeType == SocketException) {
          return "Please check your internet connection";
        }
        return "Unexpected error occurred";

      case DioExceptionType.badCertificate:
        return "Bad Certificate";

      case DioExceptionType.badResponse:
        final model = NetworkErrorModel.fromJson(
            dioException.response?.data as Map<String, dynamic>);
        return model.statusMessage ?? "Unexpected bad response";

      case DioExceptionType.unknown:
        return "Unexpected error occurred";
    }
  }

  @override
  List<Object?> get props => [message, statusCode];
}
