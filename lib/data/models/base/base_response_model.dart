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

class ResponseMeta {
  final int code;
  final String message;

  ResponseMeta({required this.code, required this.message});

  factory ResponseMeta.fromJson(Map<String, dynamic> json) {
    return ResponseMeta(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
