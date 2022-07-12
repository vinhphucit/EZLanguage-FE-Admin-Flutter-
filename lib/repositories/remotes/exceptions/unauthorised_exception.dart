import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}
