import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    if (event.phoneNumber.isEmpty ||
        event.firstName.isEmpty ||
        event.lastName.isEmpty ||
        event.password.isEmpty ||
        !_isValidPhoneNumber(event.phoneNumber)) {
      emit(const SignupFailure(
          errorMessage: 'Please enter a valid phone number'));
      return;
    }

    final response = await authRepository.registerWithPhone(
      event.phoneNumber,
      event.password,
      event.firstName,
      event.lastName,
    );

    response.fold(
      (exception) {
        String errorMessage = exception.message;
        if (exception.statusCode == 400) {
          errorMessage = 'Invalid input: $errorMessage';
        } else if (exception.statusCode == 429) {
          errorMessage = 'Too many requests: $errorMessage';
        } else if (exception.statusCode != null &&
            exception.statusCode! >= 500) {
          errorMessage = 'Server error: $errorMessage';
        }
        emit(SignupFailure(errorMessage: errorMessage));
      },
      (user) {
        emit(SignupSuccess(user: user));
      },
    );
  }
}

bool _isValidPhoneNumber(String phoneNumber) {
  final phoneRegExp = RegExp(r'^\+998\d{9}$');
  return phoneRegExp.hasMatch(phoneNumber);
}
