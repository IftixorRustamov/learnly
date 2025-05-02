part of 'sign_up_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  const SignupSubmitted({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props =>
      [firstName, lastName, phoneNumber, password];
}
