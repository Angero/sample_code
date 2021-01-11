import 'package:vizable/flows/auth/token/data/token_datasource_interface.dart';

class MockTokenDatasource implements ITokenDatasource {
  Map<String, String> _map;

  MockTokenDatasource() {
    _map = {
      ITokenDatasource.KEY_ACCESS_TOKEN: '',
      ITokenDatasource.KEY_REFRESH_TOKEN: '',
    };
  }

  @override
  Future<void> delete({String key}) async {
    await Future.delayed(Duration(milliseconds: 500));
    _map[key] = '';
  }

  @override
  Future<String> read({String key}) async {
    await Future.delayed(Duration(milliseconds: 500));
    String value = _map[key];
    if (value.isEmpty) value = null;
    return value;
  }

  @override
  Future<void> write({String key, String value}) async {
    await Future.delayed(Duration(milliseconds: 500));
    _map[key] = value;
  }
}
