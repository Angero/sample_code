import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ChangePostcodeUseCase implements IUseCase<String, String> {
  @override
  Result<String> execute([String value]) {
    if (value?.isEmpty ?? true)
      return Result(error: 'Post is empty');
    else if (!_postRegExp.hasMatch(value))
      return Result<String>(value: value, error: 'Postcode is incorrect');
    else
      return Result(value: value);
  }

  static final RegExp _postRegExp = RegExp(r'^(?=.*[0-9])[0-9]{5}$');
}
