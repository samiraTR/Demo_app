import 'dart:async';

import 'package:demo_app/bloc/counter_event.dart';

class CounterBloc {
  int counter = 0;
  final counterStateController = StreamController<int>();

  StreamSink<int> get inCounter => counterStateController.sink;

  Stream<int> get outCounter => counterStateController.stream;

  final counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => counterEventController.sink;

  CounterBloc() {
    counterEventController.stream.listen(mapEventToState);
  }

  mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      counter++;
    } else {
      counter--;
    }

    inCounter.add(counter);
  }

  // void dispose() {
  //   counterEventController.close();
  //   counterStateController.close();
  // }
}
