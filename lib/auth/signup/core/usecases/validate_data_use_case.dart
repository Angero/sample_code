import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/common/data/data.dart';

class ValidateDataUseCase implements IUseCase<Data, bool> {
  @override
  Result<bool> execute([Data value]) {
    bool ok = true;
    ok = ok && (value.get(WORD.first) != null);
    ok = ok && (value.get(WORD.last) != null);
    ok = ok && (value.get(WORD.email) != null);
    ok = ok && (value.get(WORD.birth) != null);
    ok = ok && (value.get(WORD.postcode) != null);
    ok = ok && (value.get(WORD.password) != null);

    if (ok) return Result(value: true);
    return Result(value: false, error: 'Data is invalid.');
  }
}
