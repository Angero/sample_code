import 'package:dio/dio.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/data/auth_repository_interface.dart';

class RealAuthRepository implements IAuthRepository {
  @override
  Future<Result<bool>> changePassword({String password}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> confirmCode({String code}) {
    // TODO: implement confirmCode
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> getCode({String email}) {
    // TODO: implement getCode
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> resetPassword({String password}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<TokenEntity>> signin({String email, String password}) async {
    FormData formData = new FormData.fromMap({
      'grant_type': 'client_credentials',
      'client_id': 1,
      'client_secret': 'uxJGS6doJinWUbk2ld7AxJ7WTCMVxw17Rsy1Hd21',
      "scopes": '[\'api\']',
    });
    Response response = await Dio().post(
      'https://vizable-dev-api.php-cd.attractgroup.com/api/oauth/token',
      data: formData,
    );
    String token = response.data['access_token'];

    FormData formData2 = new FormData.fromMap({
      'email': email,
      'password': password,
      "scopes": '[\'api\']',
    });
    Response response2 = await Dio().post(
      'https://vizable-dev-api.php-cd.attractgroup.com/api/auth/login',
      data: formData2,
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token, // set content-length
          },
        )
    );
    return null;
    // return Result(
    //     value: TokenEntity(
    //         accessToken: ITokenDatasource.KEY_ACCESS_TOKEN,
    //         refreshToken: ITokenDatasource.KEY_REFRESH_TOKEN));
  }

  @override
  Future<Result<TokenEntity>> signup({Data data}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
