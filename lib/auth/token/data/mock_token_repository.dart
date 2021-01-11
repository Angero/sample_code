import 'package:flutter/foundation.dart';
import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';
import 'package:vizable/flows/auth/token/data/token_repository_interface.dart';
import 'package:vizable/flows/auth/token/data/token_datasource_interface.dart';

class MockTokenRepository implements ITokenRepository {
  final ITokenDatasource datasource;

  MockTokenRepository({@required this.datasource});

  @override
  Future<void> deleteToken() async {
    await datasource.delete(key: ITokenDatasource.KEY_ACCESS_TOKEN);
  }

  @override
  Future<bool> hasToken() async {
    String accessToken =
        await datasource.read(key: ITokenDatasource.KEY_ACCESS_TOKEN);
    return accessToken != null;
  }

  @override
  Future<String> readToken() async {
    return await datasource.read(key: ITokenDatasource.KEY_ACCESS_TOKEN);
  }

  @override
  Future<TokenEntity> readTokens() async {
    String accessToken =
        await datasource.read(key: ITokenDatasource.KEY_ACCESS_TOKEN);
    String refreshToken =
        await datasource.read(key: ITokenDatasource.KEY_REFRESH_TOKEN);
    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> writeTokens(TokenEntity tokenEntity) async {
    await datasource.write(
      key: ITokenDatasource.KEY_ACCESS_TOKEN,
      value: tokenEntity.accessToken,
    );
    await datasource.write(
      key: ITokenDatasource.KEY_REFRESH_TOKEN,
      value: tokenEntity.refreshToken,
    );
  }
}
