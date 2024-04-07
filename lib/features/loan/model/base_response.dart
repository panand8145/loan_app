class BaseResponse {
  final int statusCode; // 200-Success, 500-Server-error etc.,
  final String message; // response message
  final String responseData; // API response data

  BaseResponse(
      {required this.statusCode,
      required this.message,
      required this.responseData});
}
