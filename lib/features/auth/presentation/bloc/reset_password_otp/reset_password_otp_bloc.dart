import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursol/core/exceptions/network/network_exception.dart';
import 'package:kursol/features/auth/domain/entities/otp_verify_response_entity.dart';
import 'package:kursol/features/auth/domain/usecases/reset_password_otp_usecase.dart';
import 'reset_password_otp_event.dart';
import 'reset_password_otp_state.dart';

class ResetPasswordOtpBloc
    extends Bloc<ResetPasswordOtpEvent, ResetPasswordOtpState> {
  final ResetPasswordOtpUsecase usecase;

  ResetPasswordOtpBloc({required this.usecase})
      : super(ResetPasswordOtpInitial()) {
    on<ResetPasswordOtpRequested>(_onResetPasswordOtpRequested);
  }

  Future<void> _onResetPasswordOtpRequested(
    ResetPasswordOtpRequested event,
    Emitter<ResetPasswordOtpState> emit,
  ) async {
    emit(ResetPasswordOtpLoading());

    final Either<NetworkException, OtpVerifyResponseEntity> result =
        await usecase.resetPasswordOtp(
      userId: event.userId,
      otp: event.otp,
    );

    result.fold(
      (failure) => emit(ResetPasswordOtpFailure(failure.message)),
      (response) => emit(ResetPasswordOtpSuccess(response)),
    );
  }
}
