part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class SendPostEvent<T> extends PostEvent {
  final T value;

  SendPostEvent([this.value]);
}

class InitiatePostEvent extends PostEvent {}
