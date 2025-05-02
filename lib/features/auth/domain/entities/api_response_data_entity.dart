import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class ApiResponseDataEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String? accessTokenExpiry;
  final String? refreshTokenExpiry;
  final UserEntity user;

  const ApiResponseDataEntity({
    required this.accessToken,
    required this.refreshToken,
    this.accessTokenExpiry,
    this.refreshTokenExpiry,
    required this.user,
  });

  ApiResponseDataEntity copyWith({
    String? accessToken,
    String? refreshToken,
    String? accessTokenExpiry,
    String? refreshTokenExpiry,
    UserEntity? user,
  }) {
    return ApiResponseDataEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      accessTokenExpiry: accessTokenExpiry ?? this.accessTokenExpiry,
      refreshTokenExpiry: refreshTokenExpiry ?? this.refreshTokenExpiry,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        accessTokenExpiry,
        refreshTokenExpiry,
        user,
      ];
}
