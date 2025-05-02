import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/entities/user_entity.dart';
import 'package:kursol/features/auth/domain/usecases/reset_password_via_phone_usecase.dart';

part 'reset_password_phone_event.dart';

part 'reset_password_phone_state.dart';

class ResetPasswordPhoneBloc
    extends Bloc<ResetPasswordPhoneEvent, ResetPasswordPhoneState> {
  final ResetPasswordViaPhoneUsecase usecase;

  ResetPasswordPhoneBloc({required this.usecase})
      : super(ResetPasswordPhoneInitial()) {
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
  }

  Future<void> _onResetPasswordSubmitted(ResetPasswordSubmitted event,
      Emitter<ResetPasswordPhoneState> state) async {
    if (event.phone.isEmpty || !_isValidPhoneNumber(event.phone)) {
      emit(const ResetPasswordPhoneFailure(
          message: 'Please enter a valid phone number'));
      return;
    }

    emit(ResetPasswordPhoneLoading());

    final response = await usecase.resetPasswordViaPhone(phone: event.phone);

    response.fold(
        (failure) => emit(ResetPasswordPhoneFailure(message: failure.message)),
        (success) => emit(ResetPasswordPhoneSuccess(responseEntity: success, )));
  }
}

bool _isValidPhoneNumber(String phoneNumber) {
  final phoneRegExp = RegExp(r'^\+998\d{9}$');
  return phoneRegExp.hasMatch(phoneNumber);
}
