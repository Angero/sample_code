class Data {

  Map<String, dynamic> _map;

  Data() {
    _map = Map();
  }

  dynamic get(String key) {
    return _map[key];
  }

  void set(String key, dynamic value) {
    _map[key] = value;
  }
}
