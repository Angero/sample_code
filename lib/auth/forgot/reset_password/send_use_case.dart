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
    String _password = this.data.get(WORD.password);
    if (_password == null)
      return Result(value: false, error: 'Password not found');
    String _confirm = this.data.get(WORD.confirm);
    if (_confirm == null)
      return Result(value: false, error: 'Confirm not found');

    /// Try to reset password
    Result<bool> authResult =
        await authRepository.resetPassword(password: _password);
    if (authResult.hasError())
      return Result(value: false, error: authResult.error);
    else
      return Result(value: true);
  }
}
