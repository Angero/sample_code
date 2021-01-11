part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class ChangeDataEvent extends DataEvent {
  final String key;
  final dynamic value;

  ChangeDataEvent({@required this.key, @required this.value});
}
