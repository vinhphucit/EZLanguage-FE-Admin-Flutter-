class ErrorResponse {
  String description;
  int code;

  ErrorResponse(this.code, this.description);

  factory ErrorResponse.fromJson(dynamic json) {
    return ErrorResponse(
      json['code'] as int,
      json['description'] as String,
    );
  }
}
