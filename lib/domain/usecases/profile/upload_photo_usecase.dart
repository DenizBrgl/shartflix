import 'dart:io';
import 'package:shartflix/domain/repositories/profile_repository.dart';

class UploadProfilePhotoUseCase {
  final ProfileRepository repository;

  UploadProfilePhotoUseCase(this.repository);

  Future<String> call(File file) async {
    return await repository.uploadProfilePhoto(file);
  }
}
