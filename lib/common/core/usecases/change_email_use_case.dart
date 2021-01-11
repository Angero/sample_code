import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ChangeEmailUseCase implements IUseCase<String, String> {
  @override
  Result<String> execute([String value]) {
    if (value?.isEmpty ?? true) {
      return Result<String>(value: value, error: 'Email is empty');
    } else if (!_emailRegExp.hasMatch(value)) {
      return Result<String>(value: value, error: 'Email is incorrect');
    } else {
      return Result<String>(value: value);
    }
  }

  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
}
