import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';

class InternalServerException extends HttpException {
  InternalServerException([message])
      : super(message, "Internal Server Error: ");
}
