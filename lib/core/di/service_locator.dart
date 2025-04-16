import 'package:get_it/get_it.dart';
import 'package:kursol/core/network/dio_client.dart';
import 'package:kursol/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:kursol/features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:kursol/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kursol/features/auth/domain/repositories/auth_repository.dart';
import 'package:kursol/features/auth/presentation/bloc/sign_up_bloc.dart';

import '../../features/auth/domain/usecases/register_with_email_usecase.dart';
import '../common/textstyles/app_textstyles.dart';
import '../common/textstyles/urbanist_textstyles.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AppTextStyles>(UrbanistTextStyles());
  sl.registerSingleton<UrbanistTextStyles>(UrbanistTextStyles());

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioClient: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<RegisterWithEmailUsecase>(sl());
  sl.registerFactory(()=> SignupBloc(authRepository: sl()));
}
