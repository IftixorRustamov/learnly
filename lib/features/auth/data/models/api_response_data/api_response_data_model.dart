import 'package:json_annotation/json_annotation.dart';
import 'package:kursol/features/auth/data/models/user_model/user_model.dart';

part 'api_response_data_model.g.dart';

@JsonSerializable()
class ApiResponseDataModel {
  final String accessToken;
  final String refreshToken;
  final String? accessTokenExpiry;
  final String? refreshTokenExpiry;
  final UserModel user;

  const ApiResponseDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.accessTokenExpiry,
    this.refreshTokenExpiry,
  });

  factory ApiResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseDataModelToJson(this);
}
