import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursol/features/auth/domain/entities/api_response_data_entity.dart';
import 'package:kursol/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase usecase;

  LoginBloc({required this.usecase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> state,
  ) async {
    emit(LoginLoading());

    final result =
        await usecase.call(username: event.username, password: event.password);

    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (success) => emit(LoginSuccess(success)),
    );
  }
}
