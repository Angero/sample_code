import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_event.dart';

part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  final int size;

  CarouselBloc({@required this.size}) : super(ChangedCarouselState(index: 0));

  @override
  Stream<CarouselState> mapEventToState(
    CarouselEvent event,
  ) async* {
    if (event is ChangeCarouselEvent) {
      yield ChangedCarouselState(
          index: event.index, isLast: event.index == this.size - 1);
    }
  }
}
