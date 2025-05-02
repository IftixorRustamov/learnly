import 'package:json_annotation/json_annotation.dart';

part 'otp_response_user_model.g.dart';

@JsonSerializable()
class OtpResponseUserModel {
  final String userId;

  const OtpResponseUserModel({
    required this.userId,
  });

  factory OtpResponseUserModel.fromJson(Map<String, dynamic> json) {
    return _$OtpResponseUserModelFromJson(json);
  }
}
