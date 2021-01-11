part of 'tab_bloc.dart';

@immutable
abstract class TabState {}

class SwitchedTabState extends TabState {
  final int index;

  SwitchedTabState(this.index);
}
