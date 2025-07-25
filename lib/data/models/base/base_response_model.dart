import 'response_meta.dart';

class BaseResponseModel<T> {
  final ResponseMeta response;
  final T? data;

  BaseResponseModel({required this.response, this.data});

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponseModel<T>(
      response: ResponseMeta.fromJson(json['response'] ?? {}),
      data:
          json['data'] != null && json['data'].isNotEmpty
              ? fromJsonT(json['data'])
              : null,
    );
  }
}
