import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/domain/repositories/profile_repository.dart';
import 'package:shartflix/domain/usecases/home/get_user_profile_usecase.dart';
import 'package:shartflix/domain/usecases/profile/get_liked_movies_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfile;
  final GetLikedMoviesUseCase getLikedMovies;
  final ProfileRepository profileRepository;

  ProfileBloc({
    required this.getUserProfile,
    required this.getLikedMovies,
    required this.profileRepository,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getUserProfile();
        final likedMovies = await getLikedMovies();

        emit(ProfileLoaded(user: user, likedMovies: likedMovies));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
    on<UploadProfilePhotoEvent>((event, emit) async {
      emit(ProfilePhotoUploading());
      try {
        final photoUrl = await profileRepository.uploadProfilePhoto(
          event.photoFile,
        );
        emit(ProfilePhotoUploaded(photoUrl));

        add(GetProfileEvent());
      } catch (e) {
        emit(ProfilePhotoUploadError(e.toString()));
      }
    });
  }
}
