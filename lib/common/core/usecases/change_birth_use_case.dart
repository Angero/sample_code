import 'package:date_time_picker/date_time_picker.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/flows/auth/common/services/date_time_service.dart';

class ChangeBirthUseCase implements IUseCase<String, String> {
  @override
  Result<String> execute([String value]) {
    if (value?.isEmpty ?? true)
      return Result(error: 'Date is empty');
    else
      return checkDate(value);
  }

  static Result<String> checkDate(String s) {
    DateTime dt = DateTimeService.transformDate(s);
    if (dt == null)
      return Result(error: 'Invalid date format.');
    else if (dt.year < 1920 || dt.year >= 2031) {
      return Result(error: 'Out of range.');
    } else if (DateTimeService.addYears(dt, 13).isAfter(DateTime.now())) {
      return Result(error: 'Vizable is intended for users age 13 and over.');
    } else if (DateTimeService.addYears(dt, 24).isBefore(DateTime.now())) {
      return Result(error: 'Vizable is intended for users age 24 and under.');
    } else
      return Result(value: DateFormat('dd/MM/yyyy').format(dt));
  }
}
