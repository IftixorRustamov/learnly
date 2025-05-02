import '../../domain/entities/otp_response_user_entity.dart';
import '../models/otp_response_user/otp_response_user_model.dart';

extension OtpResponseUserMapper on OtpResponseUserModel {
  OtpResponseUserEntity toEntity() {
    return OtpResponseUserEntity(
      userId: userId,
    );
  }
}
