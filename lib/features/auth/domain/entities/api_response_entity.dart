import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';

import 'api_response_error_entity.dart';

class ApiResponseEntity {
  final bool success;
  final ApiResponseDataEntity? data;
  final ApiResponseErrorEntity? error;

  ApiResponseEntity({
    required this.success,
    this.data,
    this.error,
  });
}
