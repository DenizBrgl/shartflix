import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shartflix/data/datasources/home/movie_remote_data_source.dart';
import 'package:shartflix/data/datasources/profile/profile_remote_datasource.dart';
import 'package:shartflix/data/repositories/profile_repository_impl.dart';
import 'package:shartflix/domain/repositories/profile_repository.dart';
import 'package:shartflix/domain/usecases/home/get_movies_usecase.dart';
import 'package:shartflix/domain/usecases/home/get_user_profile_usecase.dart';
import 'package:shartflix/domain/usecases/home/toggle_favorite_usecase.dart';
import 'package:shartflix/domain/usecases/profile/get_liked_movies_usecase.dart';
import 'package:shartflix/domain/usecases/profile/upload_photo_usecase.dart';
import 'package:shartflix/presentation/profile/bloc/profile_bloc.dart';

import 'package:shartflix/core/network/dio_client.dart';
import 'package:shartflix/core/network/network_info.dart';

import 'package:shartflix/data/datasources/auth/auth_remote_data_source.dart';
import 'package:shartflix/data/repositories/auth_repository_impl.dart';
import 'package:shartflix/data/repositories/movie_repository_impl.dart';

import 'package:shartflix/domain/repositories/auth_repository.dart';
import 'package:shartflix/domain/repositories/movie_repository.dart';
import 'package:shartflix/domain/usecases/auth/login_usecase.dart';
import 'package:shartflix/domain/usecases/auth/register_usecase.dart';
import 'package:shartflix/presentation/auth/bloc/auth_bloc.dart';
import 'package:shartflix/presentation/home/bloc/movie_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ------------------ CORE ------------------
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(sl<Dio>(), sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  //! ------------------ NETWORK ------------------
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(Connectivity()));

  //! ------------------ DATA SOURCES ------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  //! ------------------ REPOSITORIES ------------------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      storage: sl<FlutterSecureStorage>(),
      dioClient: sl<DioClient>(),
    ),
  );

  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl<MovieRemoteDataSource>()),
  );

  //! ------------------ USE CASES ------------------
  sl.registerLazySingleton(
    () => LoginUseCase(sl<AuthRepository>(), sl<INetworkInfo>()),
  );
  sl.registerLazySingleton(
    () => RegisterUseCase(sl<AuthRepository>(), sl<INetworkInfo>()),
  );
  sl.registerLazySingleton(() => GetMoviesUseCase(sl<MovieRepository>()));

  //! ------------------ BLOCS ------------------
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      getUserProfile: sl<GetUserProfileUseCase>(),
      getLikedMovies: sl<GetLikedMoviesUseCase>(),
      profileRepository: sl<ProfileRepository>(),
    ),
  );

  sl.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl<MovieRepository>()),
  );

  sl.registerFactory(
    () => MovieBloc(sl<GetMoviesUseCase>(), sl<ToggleFavoriteUseCase>()),
  );
  // REPOSITORY
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()),
  );

  // USE CASE
  sl.registerLazySingleton(
    () => GetUserProfileUseCase(sl<ProfileRepository>()),
  );

  // BLOC
  sl.registerLazySingleton(
    () => GetLikedMoviesUseCase(sl()),
  ); // ✅ Yeni use case
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton(
    () => UploadProfilePhotoUseCase(sl<ProfileRepository>()),
  );
}
