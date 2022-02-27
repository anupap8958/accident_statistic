class ApiResult {
  final int resultCode;
  final dynamic result;

  ApiResult({
    required this.resultCode,
    required this.result,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      resultCode: json['resultCode'],
      result: json['result'],
    );
  }
}
