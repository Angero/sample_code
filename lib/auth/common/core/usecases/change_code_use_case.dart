import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ChangeCodeUseCase implements IUseCase<String, String> {
  @override
  Result<String> execute([String value]) {
    if (value?.isEmpty ?? true) {
      return Result<String>(value: value, error: 'Code is empty');
    } else if (!_codeExp.hasMatch(value)) {
      return Result<String>(value: value, error: 'Code is incorrect');
    } else {
      return Result<String>(value: value);
    }
  }

  static final RegExp _codeExp = RegExp(r'^(?=.*[0-9])[0-9]{4}$');
}
