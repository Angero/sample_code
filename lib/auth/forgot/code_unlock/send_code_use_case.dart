import 'package:flutter/foundation.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/flows/auth/common/data/auth_repository_interface.dart';
import 'package:vizable/flows/auth/token/data/token_repository_interface.dart';

class SendUseCase implements IFutureUseCase<String, bool> {
  final IAuthRepository authRepository;
  final ITokenRepository tokenRepository;
  final Data data;

  const SendUseCase({
    @required this.authRepository,
    @required this.tokenRepository,
    @required this.data,
  });

  @override
  Future<Result<bool>> execute([String value]) async {
    String _code = this.data.get(WORD.code);
    if (_code == null) return Result(value: false, error: 'Code not found');

    /// Try to send query to get code
    Result<bool> authResult = await authRepository.confirmCode(code: _code);
    if (authResult.hasError())
      return Result(value: false, error: authResult.error);
    else
      return Result(value: true);
  }
}
