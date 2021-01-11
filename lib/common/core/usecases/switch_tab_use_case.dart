import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';

class SwitchTabUseCase implements IUseCase<int, int> {
  @override
  Result<int> execute([int value]) => Result(value: value);
}
