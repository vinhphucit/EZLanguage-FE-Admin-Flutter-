import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';

class BadRequestException extends HttpException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
