part of 'otp_verify_bloc.dart';

class OtpVerifyState extends Equatable {
  const OtpVerifyState();

  @override
  List<Object?> get props => [];
}

final class OtpVerifyInitial extends OtpVerifyState {}

final class OtpVerifyLoading extends OtpVerifyState {}

final class OtpVerifySuccess extends OtpVerifyState {
  final OtpVerifyResponseEntity message;

  const OtpVerifySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class OtpVerifyFailure extends OtpVerifyState {
  final String message;

  const OtpVerifyFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
