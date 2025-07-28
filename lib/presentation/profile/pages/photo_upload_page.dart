import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shartflix/presentation/auth/widgets/custom_elevated_button.dart';

import 'package:shartflix/core/theme/app_colors.dart';
import 'package:shartflix/core/theme/app_styles.dart';

import 'package:shartflix/presentation/profile/bloc/profile_bloc.dart';
import 'package:shartflix/presentation/profile/bloc/profile_event.dart';
import 'package:shartflix/presentation/profile/bloc/profile_state.dart';

class PhotoUploadPage extends StatefulWidget {
  const PhotoUploadPage({super.key});

  @override
  State<PhotoUploadPage> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _onContinuePressed() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("no_image_selected".tr()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<ProfileBloc>().add(UploadProfilePhotoEvent(_selectedImage!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "profile_details".tr(),
          style: AppStyles.euclidCircularAMedium.copyWith(
            fontSize: 15,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfilePhotoUploading) {
          } else if (state is ProfilePhotoUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("photo_upload_success".tr()),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pop(context, true);
          } else if (state is ProfilePhotoUploadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("upload_error".tr(args: [state.message])),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final bool isUploading = state is ProfilePhotoUploading;

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "add_profile_photo".tr(),
                    style: AppStyles.euclidCircularABold.copyWith(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "upload_photo_description".tr(),
                    style: AppStyles.bodyText1.copyWith(
                      color: AppColors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(31),
                        border: Border.all(color: AppColors.white70, width: 1),
                        image:
                            _selectedImage != null
                                ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                                : null,
                      ),
                      child:
                          _selectedImage == null
                              ? const Icon(
                                Icons.add,
                                color: AppColors.white70,
                                size: 50,
                              )
                              : null,
                    ),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    textKey: "continue",
                    onPressed: _onContinuePressed,
                    isLoading: isUploading,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
