import 'package:dio/dio.dart';
import 'package:shartflix/core/error/exceptions.dart';
import '../config/app_config.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.options.headers = AppConfig.jsonHeaders;
    dio.options.connectTimeout = AppConfig.requestTimeout;
    dio.options.receiveTimeout = AppConfig.requestTimeout;
  }

  Future<Response<T>> post<T>(String path, {Map<String, dynamic>? data}) async {
    try {
      return await dio.post<T>(
        path,
        data: data,
        options: Options(
          headers: AppConfig.jsonHeaders,
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      }

      if (e.response?.statusCode == 401) {
        throw UnauthorizedException("Yetkisiz erişim.");
      }

      throw ServerException(
        e.response?.data['response']?['message'] ?? 'Sunucu hatası',
      );
    } catch (e) {
      throw UnknownException("Beklenmeyen bir hata: $e");
    }
  }
}
