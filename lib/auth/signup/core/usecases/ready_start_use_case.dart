import 'package:flutter/foundation.dart';
import 'package:vizable/flows/auth/common/core/result.dart';

class ReadyStartUseCase {
  static bool execute({
    @required Result<String> firstResult,
    @required Result<String> lastResult,
    @required Result<String> emailResult,
    @required Result<String> birthResult,
    @required Result<String> postResult,
    @required Result<String> passwordResult,
  }) {
    if (firstResult == null) return false;
    if (lastResult == null) return false;
    if (emailResult == null) return false;
    if (birthResult == null) return false;
    if (postResult == null) return false;
    if (passwordResult == null) return false;
    return !firstResult.hasError() &&
        !lastResult.hasError() &&
        !emailResult.hasError() &&
        !birthResult.hasError() &&
        !postResult.hasError() &&
        !passwordResult.hasError();
  }
}
