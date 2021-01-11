part of 'access_bloc.dart';

@immutable
abstract class AccessState {}

class InitialAccessState extends AccessState {}

class GettingAccessState extends AccessState {}

class AccessibleAccessState extends AccessState {}

class DeniedAccessState extends AccessState {}

class FailureAccessState extends AccessState {}
