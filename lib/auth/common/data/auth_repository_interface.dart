import 'package:flutter/foundation.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';
import 'package:vizable/flows/auth/common/core/result.dart';

abstract class IAuthRepository {
  Future<Result<TokenEntity>> signin(
      {@required String email, @required String password});

  Future<Result<TokenEntity>> signup({@required Data data});

  Future<Result<bool>> getCode({@required String email});

  Future<Result<bool>> confirmCode({@required String code});

  Future<Result<bool>> resetPassword({@required String password});

  Future<Result<bool>> changePassword({@required String password});
}
