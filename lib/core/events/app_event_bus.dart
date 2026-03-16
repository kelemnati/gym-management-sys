import 'package:event_bus/event_bus.dart';
import 'app_events.dart';

class AppEventBus {
  final EventBus _eventBus = EventBus();

  void fire(AppEvent event) {
    _eventBus.fire(event);
  }

  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
}
