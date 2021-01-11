part of 'carousel_bloc.dart';

@immutable
abstract class CarouselEvent {}

class ChangeCarouselEvent extends CarouselEvent {
  final int index;

  ChangeCarouselEvent({@required this.index});
}
