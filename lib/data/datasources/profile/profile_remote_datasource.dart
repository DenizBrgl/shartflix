import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shartflix/data/models/auth/user_model.dart';
import 'package:shartflix/data/models/movie/movie_model.dart';
import 'package:shartflix/core/error/exceptions.dart';
import 'package:shartflix/core/network/dio_client.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<List<MovieModel>> getLikedMovies();
  Future<String> uploadProfilePhoto(File photoFile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final response = await _dioClient.get('/user/profile');

      final data = response.data['data'];
      return UserModel.fromJson(data);
    } catch (e) {
      throw ServerException("Kullanıcı profili alınırken hata oluştu: $e");
    }
  }

  Future<List<MovieModel>> getLikedMovies() async {
    try {
      final response = await _dioClient.get('/movie/favorites');

      final List<dynamic> movieJsonList = response.data['data'];
      return movieJsonList.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException("Beğenilen filmler alınırken hata oluştu: $e");
    }
  }

  @override
  Future<String> uploadProfilePhoto(File photoFile) async {
    try {
      final fileName = photoFile.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          photoFile.path,
          filename: fileName,
        ),
      });

      final response = await _dioClient.post(
        '/user/upload_photo',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data.containsKey('photoUrl')) {
        return response.data['photoUrl'] as String;
      } else {
        throw ServerException(
          "Fotoğraf yükleme başarısız: ${response.statusCode} - ${response.data}",
        );
      }
    } on DioException catch (e) {
      // Hata mesajını daha detaylı gösterebiliriz
      String errorMessage = "Sunucu hatası";
      if (e.response != null) {
        errorMessage =
            e.response?.data['message'] ??
            e.response?.data['error'] ??
            "Sunucu hatası: ${e.response?.statusCode}";
      } else {
        errorMessage = "Ağ hatası: ${e.message}";
      }
      throw ServerException(errorMessage);
    } catch (e) {
      throw ServerException("Fotoğraf yüklenirken beklenmeyen bir hata: $e");
    }
  }
}
