import 'package:get_it/get_it.dart';
import 'package:kursol/core/database/hive_initializer.dart';
import 'package:kursol/core/network/dio_client.dart';
import 'package:kursol/features/auth/data/datasources/local/token_storage.dart';
import 'package:kursol/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:kursol/features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:kursol/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';
import 'package:kursol/features/auth/domain/usecases/login_usecase.dart';
import 'package:kursol/features/auth/domain/usecases/register_with_phone_usecase.dart';
import 'package:kursol/features/auth/domain/usecases/reset_password_otp_usecase.dart';
import 'package:kursol/features/auth/domain/usecases/reset_password_via_phone_usecase.dart';
import 'package:kursol/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:kursol/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:kursol/features/auth/presentation/bloc/otp_verify/otp_verify_bloc.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_otp/reset_password_otp_bloc.dart';
import 'package:kursol/features/auth/presentation/bloc/reset_password_phone/reset_password_phone_bloc.dart';
import 'package:kursol/features/auth/presentation/bloc/sign_up_bloc.dart';

import '../common/textstyles/app_textstyles.dart';
import '../common/textstyles/urbanist_textstyles.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<HiveInitializer>(HiveInitializer());
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  // Core
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<AppTextStyles>(UrbanistTextStyles());
  sl.registerSingleton<UrbanistTextStyles>(UrbanistTextStyles());

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      tokenStorage: sl<TokenStorage>()));

  //? Usecases
  sl.registerLazySingleton<RegisterWithPhoneUseCase>(
    () => RegisterWithPhoneUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton<ResetPasswordViaPhoneUsecase>(
      () => ResetPasswordViaPhoneUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton<ResetPasswordOtpUsecase>(
      () => ResetPasswordOtpUsecase(sl<AuthRepository>()));

  //? Bloc
  sl.registerFactory<SignupBloc>(
      () => SignupBloc(authRepository: sl<AuthRepository>()));
  sl.registerFactory<OtpVerifyBloc>(
      () => OtpVerifyBloc(usecase: sl<VerifyOtpUseCase>()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(usecase: sl<LoginUsecase>()));
  sl.registerFactory<ResetPasswordPhoneBloc>(() =>
      ResetPasswordPhoneBloc(usecase: sl<ResetPasswordViaPhoneUsecase>()));
  sl.registerFactory<ResetPasswordOtpBloc>(
      () => ResetPasswordOtpBloc(usecase: sl<ResetPasswordOtpUsecase>()));
}
