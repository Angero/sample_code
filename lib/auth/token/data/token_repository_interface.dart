import 'package:vizable/flows/auth/common/core/entities/token_entity.dart';

abstract class ITokenRepository {
  Future<bool> hasToken();
  Future<String> readToken();
  Future<TokenEntity> readTokens();
  Future<void> writeTokens(TokenEntity tokenEntity);
  Future<void> deleteToken();
}