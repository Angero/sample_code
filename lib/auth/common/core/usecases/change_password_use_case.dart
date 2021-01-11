import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ChangePasswordUseCase implements IUseCase<String, String> {
  @override
  Result<String> execute([String value]) {
    if (value?.isEmpty ?? true) {
      return Result<String>(value: value, error: 'Password is empty');
    } else if (!_passwordRegExp.hasMatch(value)) {
      return Result<String>(
          value: value,
          error:
              'Your password must be 8-16 characters, and include at least one lowercase letter, one uppercase letter, and a number.');
    } else {
      return Result<String>(value: value);
    }
  }

  static final RegExp _passwordRegExp =

      /// Password must be 8-16 characters, and include at least one lowercase letter, one uppercase letter, and a number.
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\d)[A-Za-z\d]{8,16}$');
}
