part of 'carousel_bloc.dart';

@immutable
abstract class CarouselState {}

class ChangedCarouselState extends CarouselState {
  final int index;
  final bool isLast;

  ChangedCarouselState({
    @required this.index,
    this.isLast = false,
  });
}
