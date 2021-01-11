part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class InitialPostState  extends PostState {}

class WaitingPostState extends PostState {}

class SuccessPostState extends PostState {}

class FailurePostState extends PostState {
  final String error;

  FailurePostState(this.error);
}
