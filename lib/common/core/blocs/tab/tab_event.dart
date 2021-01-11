part of 'tab_bloc.dart';

@immutable
abstract class TabEvent {}

class SwitchTabEvent extends TabEvent {
  final int index;

  SwitchTabEvent(this.index);
}
