import 'package:equatable/equatable.dart';

abstract class ResetPasswordOtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetPasswordOtpRequested extends ResetPasswordOtpEvent {
  final String userId;
  final String otp;

  ResetPasswordOtpRequested({required this.userId, required this.otp});

  @override
  List<Object> get props => [userId, otp];
}
