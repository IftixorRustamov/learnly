import 'package:kursol/features/auth/data/mappers/user_mapper.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';

import '../models/api_response_data/api_response_data_model.dart';

extension ApiResponseDataModelMapper on ApiResponseDataModel {
  ApiResponseDataEntity toEntity() {
    return ApiResponseDataEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessTokenExpiry: accessTokenExpiry,
      refreshTokenExpiry: refreshTokenExpiry,
      user: user.toEntity(),
    );
  }
}
