import 'dart:io';

import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/entities/profile/user_entity_profile.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
  Future<List<MovieEntity>> getLikedMovies();
  Future<String> uploadProfilePhoto(File photoFile);
}
