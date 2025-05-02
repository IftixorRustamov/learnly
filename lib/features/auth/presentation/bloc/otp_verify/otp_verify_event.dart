part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent extends Equatable {
  const OtpVerifyEvent();

  @override
  List<Object?> get props => [];
}

class OtpVerifyRequested extends OtpVerifyEvent {
  final String otpCode;
  final String userId;

  const OtpVerifyRequested({
    required this.otpCode,
    required this.userId,
  });

  @override
  List<Object?> get props => [otpCode, userId];
}
