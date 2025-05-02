import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/api_response_error_entity.dart';

part 'api_response_error.g.dart';

@JsonSerializable()
class ApiResponseErrorModel extends ApiResponseErrorEntity {
  ApiResponseErrorModel({super.code, super.message, super.details});

  factory ApiResponseErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseErrorModelFromJson(json);
}
