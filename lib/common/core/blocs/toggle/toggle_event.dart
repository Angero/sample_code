part of 'toggle_bloc.dart';

@immutable
abstract class ToggleEvent {}

class TurnOnToggleEvent extends ToggleEvent {}

class TurnOffToggleEvent extends ToggleEvent {}