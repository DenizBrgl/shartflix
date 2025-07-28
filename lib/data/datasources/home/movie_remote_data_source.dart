import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shartflix/data/models/base/base_response_model.dart';
import 'package:shartflix/data/models/movie/movie_model.dart';
import 'package:shartflix/core/error/exceptions.dart';
import 'package:shartflix/core/network/dio_client.dart';

abstract class MovieRemoteDataSource {
  Future<BaseResponseModel<List<MovieModel>>> getMovies(int page);
  Future<void> toggleFavorite(String movieId, bool isFavorite);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<BaseResponseModel<List<MovieModel>>> getMovies(int page) async {
    try {
      final response = await dioClient.get('/movie/list?page=$page');
      print(response.data.runtimeType); // bunu ekle

      return BaseResponseModel.fromJson(response.data, (json) {
        final movies = json['movies'] as List;
        return movies.map((e) => MovieModel.fromJson(e)).toList();
      });
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw ServerException("Filmler alınırken hata oluştu: $e");
    }
  }

  Future<void> toggleFavorite(String movieId, bool isFavorite) async {
    try {
      if (isFavorite) {
        await dioClient.post('/movie/favorite/$movieId');
      } else {
        await dioClient.delete('/movie/favorite/$movieId');
      }
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw ServerException("Favori güncelleme hatası: $e");
    }
  }
}
