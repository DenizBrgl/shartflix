import 'package:equatable/equatable.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/entities/profile/user_entity_profile.dart'; // User entity import edildi

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final List<MovieEntity> likedMovies;

  const ProfileLoaded({required this.user, required this.likedMovies});

  @override
  List<Object> get props => [user, likedMovies];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfilePhotoUploading extends ProfileState {}

class ProfilePhotoUploaded extends ProfileState {
  final String photoUrl;

  ProfilePhotoUploaded(this.photoUrl);
}

class ProfilePhotoUploadError extends ProfileState {
  final String message;

  ProfilePhotoUploadError(this.message);
}
