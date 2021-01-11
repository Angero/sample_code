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
    String _email = this.data.get(WORD.email);
    if (_email == null) return Result(value: false, error: 'Email not found');

    /// Try to send query to get code
    Result<bool> authResult = await authRepository.getCode(email: _email);
    if (authResult.hasError())
      return Result(value: false, error: authResult.error);
    else
      return Result(value: true);
  }
}
