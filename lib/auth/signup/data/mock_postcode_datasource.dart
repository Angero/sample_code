class MockPostcodeDatasource {
  List<String> _list = List();

  MockPostcodeDatasource() {
    _list = List.generate(1000,(int index) {
      String prefix =  '0'* (5 - index.toString().length);
      return prefix + index.toString();
    });
    _list.removeAt(0);
  }

  List<String> get list => _list;
}