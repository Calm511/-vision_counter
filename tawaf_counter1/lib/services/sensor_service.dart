import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:stream_transform/stream_transform.dart';

class SensorService {
  final StreamController<AccelerometerEvent> _accelController = StreamController<AccelerometerEvent>.broadcast();
  StreamSubscription<AccelerometerEvent>? _accelSub;

  Stream<AccelerometerEvent> get accelerometer => _accelController.stream;

  void start() {
    _accelSub = accelerometerEvents
        .throttle(const Duration(milliseconds: 500))
        .listen(_accelController.add);
  }

  void pause() {
    _accelSub?.pause();
  }

  void resume() {
    _accelSub?.resume();
  }

  void stop() {
    _accelSub?.cancel();
  }

  void dispose() {
    stop();
    _accelController.close();
  }
}