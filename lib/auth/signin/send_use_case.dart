import 'package:flutter/foundation.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';
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
    String _email = this.data.get(WORD.email);
    String _password = this.data.get(WORD.password);
    if (_email == null) return Result(value: false, error: 'Email not found');
    if (_password == null)
      return Result(value: false, error: 'Password not found');

    /// Try to get access token
    Result<TokenEntity> authResult =
        await authRepository.signin(email: _email, password: _password);
    if (authResult.hasError())
      return Result(value: false, error: authResult.error);

    /// Try to save token
    try {
      await tokenRepository.writeTokens(authResult.value);
      return Result(value: true);
    } catch (e, stacktrace) {
      print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
      return Result(value: false, error: 'Failed to save token.');
    }
  }
}
