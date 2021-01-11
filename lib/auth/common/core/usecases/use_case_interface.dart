import 'package:vizable/flows/auth/common/core/result.dart';

abstract class IUseCase<S, R> {
  Result<R> execute([S value]);
}

abstract class IFutureUseCase<S, R> {
  Future<Result<R>> execute([S value]);
}