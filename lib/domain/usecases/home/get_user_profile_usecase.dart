import 'package:shartflix/domain/entities/profile/user_entity_profile.dart';
import 'package:shartflix/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> call() async {
    return await repository.getUserProfile();
  }
}
