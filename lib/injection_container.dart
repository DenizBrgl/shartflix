import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shartflix/core/network/dio_client.dart';
import 'package:shartflix/core/network/network_info.dart';

import 'package:shartflix/data/datasources/auth/auth_remote_data_source.dart';
import 'package:shartflix/data/repositories/auth_repository_impl.dart';

import 'package:shartflix/domain/repositories/auth_repository.dart';
import 'package:shartflix/domain/usecases/auth/login_usecase.dart';
import 'package:shartflix/domain/usecases/auth/register_usecase.dart';

import 'package:shartflix/presentation/auth/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ------------------ CORE ------------------

  // Dio instance
  sl.registerLazySingleton<Dio>(() => Dio());

  // DioClient with injected Dio
  sl.registerLazySingleton<DioClient>(() => DioClient(sl<Dio>()));

  // FlutterSecureStorage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  //! ------------------ NETWORK ------------------

  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(Connectivity()));

  //! ------------------ DATA SOURCES ------------------

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  //! ------------------ REPOSITORIES ------------------

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  //! ------------------ USE CASES ------------------

  sl.registerLazySingleton(
    () => LoginUseCase(sl<AuthRepository>(), sl<INetworkInfo>()),
  );
  sl.registerLazySingleton(
    () => RegisterUseCase(sl<AuthRepository>(), sl<INetworkInfo>()),
  );

  //! ------------------ BLOCS ------------------

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
    ),
  );
}
