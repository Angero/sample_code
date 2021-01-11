import 'package:flutter/foundation.dart';
import 'package:vizable/flows/auth/signup/data/mock_postcode_datasource.dart';
import 'package:vizable/flows/auth/signup/data/postcode_repository_interface.dart';

class MockPostcodeRepository implements IPostcodeRepositoryInterface {
  final MockPostcodeDatasource datasource;

  MockPostcodeRepository({@required this.datasource});

  @override
  List<String> getFilteredList(String filter) {
    List<String> _list = List();
    if (filter == null) return _list;
    for (String value in datasource.list)
      if (value.contains(filter)) _list.add(value);
    return _list;
  }
}
