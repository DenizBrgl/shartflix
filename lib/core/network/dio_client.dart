import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shartflix/core/error/exceptions.dart';
import '../config/app_config.dart';

class DioClient {
  final Dio dio;
  final FlutterSecureStorage storage;
  String? _authToken;
  DioClient(this.dio, this.storage) {
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.options.headers = AppConfig.jsonHeaders;
    dio.options.connectTimeout = AppConfig.requestTimeout;
    dio.options.receiveTimeout = AppConfig.requestTimeout;
  }
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      await _loadTokenFromStorage();
      return await dio.post<T>(
        path,
        data: data,
        options:
            options ??
            Options(
              headers: {
                ...AppConfig.jsonHeaders,
                if (_authToken != null) 'Authorization': 'Bearer $_authToken',
              },
              validateStatus: (status) => status != null && status < 500,
            ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      }

      if (e.response?.statusCode == 401) {
        // clearAuthToken();

        throw UnauthorizedException("Yetkisiz erişim.");
      }

      throw ServerException(
        e.response?.data['response']?['message'] ?? 'Sunucu hatası',
      );
    } catch (e) {
      throw UnknownException("Beklenmeyen bir hata: $e");
    }
  }

  Future<Response<T>> get<T>(
    String path, {

    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print("Auth header: Bearer $_authToken");
      await _loadTokenFromStorage();
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ...AppConfig.jsonHeaders,
            if (_authToken != null) 'Authorization': 'Bearer $_authToken',
          },

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

  Future<Response<T>> delete<T>(String path) async {
    try {
      return await dio.delete<T>(
        path,
        options: Options(
          headers: {
            ...AppConfig.jsonHeaders,
            if (_authToken != null) 'Authorization': 'Bearer $_authToken',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Sunucu hatası");
    }
  }

  Future<void> _loadTokenFromStorage() async {
    _authToken = await storage.read(key: 'auth_token');
  }

  void setAuthToken(String token) {
    _authToken = token;
    storage.write(key: 'auth_token', value: token); // ✅ senkronize et
  }

  void clearAuthToken() {
    _authToken = null;
    storage.delete(key: 'auth_token');
  }
}
