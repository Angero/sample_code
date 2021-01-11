import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class ValidateDataUseCase implements IUseCase<Data, bool> {
  @override
  Result<bool> execute([Data value]) {
    if (value.get(WORD.email) != null && value.get(WORD.password) != null)
      return Result(value: true);
    return Result(value: false, error: 'Data is invalid.');
  }
}