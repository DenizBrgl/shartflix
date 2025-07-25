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
