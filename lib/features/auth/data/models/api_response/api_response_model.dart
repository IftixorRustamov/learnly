import 'package:json_annotation/json_annotation.dart';
import 'package:kursol/features/auth/data/models/api_response_data/api_response_data_model.dart';
import 'package:kursol/features/auth/data/models/api_response_error/api_response_error.dart';

part 'api_response_model.g.dart';

@JsonSerializable()
class ApiResponseModel {
  final bool success;
  final ApiResponseDataModel? data;
  final ApiResponseErrorModel? error;

  ApiResponseModel({
    required this.success,
    this.data,
    this.error,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);
}
