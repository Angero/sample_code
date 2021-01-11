import 'package:flutter/foundation.dart';

abstract class ITokenDatasource {
  static const KEY_ACCESS_TOKEN = 'access_token';
  static const KEY_REFRESH_TOKEN = 'refresh_token';

  Future<String> read({@required String key});

  Future<void> write({@required String key, @required String value});

  Future<void> delete({@required String key});
}
