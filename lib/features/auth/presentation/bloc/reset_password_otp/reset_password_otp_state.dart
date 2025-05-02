import 'package:equatable/equatable.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';

abstract class ResetPasswordOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordOtpInitial extends ResetPasswordOtpState {}

class ResetPasswordOtpLoading extends ResetPasswordOtpState {}

class ResetPasswordOtpSuccess extends ResetPasswordOtpState {
  final OtpVerifyResponseEntity response;

  ResetPasswordOtpSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ResetPasswordOtpFailure extends ResetPasswordOtpState {
  final String error;

  ResetPasswordOtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}
