import 'package:flutter/foundation.dart';
import 'package:vizable/flows/auth/common/core/result.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/flows/auth/signup/data/postcode_repository_interface.dart';

class FindCodeUseCase implements IFutureUseCase<String, List<String>> {
  final IPostcodeRepositoryInterface repository;

  FindCodeUseCase({@required this.repository});

  @override
  Future<Result<List<String>>> execute([String value]) async {
    await Future.delayed(Duration(milliseconds: 10));
    return Result(value: repository.getFilteredList(value));
  }

}