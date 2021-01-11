import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ValidatePasswordUseCase implements IUseCase<Data, bool> {
  @override
  Result<bool> execute([Data value]) {
    if (value.get(WORD.password) != null &&
        value.get(WORD.confirm) != null &&
        value.get(WORD.password) == value.get(WORD.confirm))
      return Result(value: true);
    return Result(value: false, error: 'Data is invalid.');
  }
}
