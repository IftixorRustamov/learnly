import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';
import 'package:kursol/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:meta/meta.dart';

part 'otp_verify_event.dart';

part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final VerifyOtpUseCase usecase;

  OtpVerifyBloc({required this.usecase}) : super(OtpVerifyInitial()) {
    on<OtpVerifyRequested>(_onOtpVerifyRequested);
  }

  Future<void> _onOtpVerifyRequested(
    OtpVerifyRequested event,
    Emitter<OtpVerifyState> state,
  ) async {
    emit(OtpVerifyLoading());

    final result = await usecase.verifyOtp(
      otpCode: event.otpCode,
      userId: event.userId,
    );

    result.fold((failure) {
      emit(OtpVerifyFailure(message: failure.message));
    }, (success) {
      emit(OtpVerifySuccess(message: success));
    });
  }
}
