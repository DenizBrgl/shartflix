import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shartflix/core/error/exceptions.dart';
import 'package:shartflix/data/models/auth/request/register_request_model.dart';
import 'package:shartflix/data/models/auth/user_model.dart';
import 'package:shartflix/data/models/base/base_response_model.dart';
import 'package:shartflix/core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponseModel<UserModel>> login({
    required String email,
    required String password,
  });

  Future<BaseResponseModel<UserModel>> register({
    required RegisterRequestModel request,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<BaseResponseModel<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        '/user/login',
        data: {'email': email, 'password': password},
      );

      return BaseResponseModel<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw ServerException("Login API hatası: $e");
    }
  }

  @override
  Future<BaseResponseModel<UserModel>> register({
    required RegisterRequestModel request,
  }) async {
    try {
      final response = await dioClient.post(
        '/user/register',
        data: request.toJson(),
      );

      return BaseResponseModel<UserModel>.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      throw ServerException("Register API hatası: $e");
    }
  }
}
