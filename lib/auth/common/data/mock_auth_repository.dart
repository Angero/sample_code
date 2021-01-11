import 'package:flutter/foundation.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/data/auth_repository_interface.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/token/data/token_datasource_interface.dart';

class MockAuthRepository implements IAuthRepository {
  @override
  Future<Result<TokenEntity>> signin(
      {@required String email, @required String password}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (email == 'test@test.com' && password == 'secret')
      return Result(
          value: TokenEntity(
              accessToken: ITokenDatasource.KEY_ACCESS_TOKEN,
              refreshToken: ITokenDatasource.KEY_REFRESH_TOKEN));
    else
      return Result(error: 'Failure when try to sign in.'); //todo:
  }

  @override
  Future<Result<TokenEntity>> signup({Data data}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (data.get(WORD.email) == 'test@test.com')
      return Result(
          value: TokenEntity(
              accessToken: ITokenDatasource.KEY_ACCESS_TOKEN,
              refreshToken: ITokenDatasource.KEY_REFRESH_TOKEN));
    else
      return Result(error: 'Failure when try to sign up.'); //todo
  }

  @override
  Future<Result<bool>> getCode({String email}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (email == 'test@test.com')
      return Result(value: true);
    else
      return Result(value: false, error: 'Failure when try to send code.');
  }

  @override
  Future<Result<bool>> confirmCode({String code}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (code == '1111')
      return Result(value: true);
    else
      return Result(value: false, error: 'Failure when try to confirm code.');
  }

  @override
  Future<Result<bool>> resetPassword({String password}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (password == 'secret')
      return Result(value: true);
    else
      return Result(value: false, error: 'Failure when try to reset password.');
  }

  @override
  Future<Result<bool>> changePassword({String password}) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (password == 'secret')
      return Result(value: true);
    else
      return Result(value: false, error: 'Failure when try to change password.');
  }
}
