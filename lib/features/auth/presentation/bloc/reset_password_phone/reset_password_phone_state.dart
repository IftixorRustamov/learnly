part of 'reset_password_phone_bloc.dart';

abstract class ResetPasswordPhoneState extends Equatable {
  const ResetPasswordPhoneState();

  @override
  List<Object?> get props => [];
}

final class ResetPasswordPhoneInitial extends ResetPasswordPhoneState {
  const ResetPasswordPhoneInitial();
}

final class ResetPasswordPhoneLoading extends ResetPasswordPhoneState {
  const ResetPasswordPhoneLoading();
}

final class ResetPasswordPhoneSuccess extends ResetPasswordPhoneState {
  final OtpVerifyResponseEntity responseEntity;
  final UserEntity? userEntity;

  const ResetPasswordPhoneSuccess(
      {required this.responseEntity, this.userEntity});

  @override
  List<Object?> get props => [responseEntity, userEntity];
}

final class ResetPasswordPhoneFailure extends ResetPasswordPhoneState {
  final String message;

  const ResetPasswordPhoneFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
