import 'dart:io';

import 'package:shartflix/data/datasources/profile/profile_remote_datasource.dart';
import 'package:shartflix/data/models/movie/movie_model.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/entities/profile/user_entity_profile.dart';
import 'package:shartflix/domain/repositories/profile_repository.dart';
import 'package:shartflix/core/error/exceptions.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> getUserProfile() async {
    final model = await remoteDataSource.getUserProfile();
    return model.toUserEntity();
  }

  @override
  Future<List<MovieEntity>> getLikedMovies() async {
    final models = await remoteDataSource.getLikedMovies();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<String> uploadProfilePhoto(File photoFile) async {
    try {
      final photoUrl = await remoteDataSource.uploadProfilePhoto(photoFile);
      return photoUrl;
    } on ServerException catch (e) {
      throw e;
    } catch (e) {
      throw Exception(
        "Profil fotoğrafı yüklenirken beklenmeyen bir hata oluştu: $e",
      );
    }
  }
}
