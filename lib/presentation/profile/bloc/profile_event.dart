import 'dart:io';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UploadProfilePhotoEvent extends ProfileEvent {
  final File photoFile;

  UploadProfilePhotoEvent(this.photoFile);
}
