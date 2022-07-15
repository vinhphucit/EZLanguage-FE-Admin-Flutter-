class HttpException implements Exception {
  final _message;
  final _prefix;

  HttpException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}
