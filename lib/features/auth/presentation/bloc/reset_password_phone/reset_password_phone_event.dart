part of 'reset_password_phone_bloc.dart';

abstract class ResetPasswordPhoneEvent extends Equatable {
  const ResetPasswordPhoneEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordSubmitted extends ResetPasswordPhoneEvent {
  final String phone;

  const ResetPasswordSubmitted({required this.phone});

  @override
  List<Object> get props => [phone];
}
