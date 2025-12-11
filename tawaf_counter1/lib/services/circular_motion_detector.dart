import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class CircularMotionDetector {
  final Stream<double> headingStream;
  final Stream<AccelerometerEvent> accelStream;
  final StreamController<bool> _isMovingCircularlyController = StreamController<bool>.broadcast();

  Stream<bool> get isMovingCircularly => _isMovingCircularlyController.stream;

  Timer? _movementTimer;
  double? _lastHeading;
  bool _isMoving = false;

  CircularMotionDetector(this.headingStream, this.accelStream) {
    _init();
  }

  void _init() {
    headingStream.listen((heading) {
      if (_lastHeading != null) {
        final delta = (heading - _lastHeading!).abs();
        if (delta > 1) {
          // منطق بسيط
        }
      }
      _lastHeading = heading;
      _updateCircularMotion();
    });

    accelStream.listen((event) {
      final magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (magnitude > 1.5) {
        _isMoving = true;
        _movementTimer?.cancel();
        _movementTimer = Timer(const Duration(seconds: 2), () {
          _isMoving = false;
          _updateCircularMotion();
        });
      }
      _updateCircularMotion();
    });
  }

  void _updateCircularMotion() {
    final isCircular = _isMoving;
    _isMovingCircularlyController.add(isCircular);
  }

  void dispose() {
    _movementTimer?.cancel();
    _isMovingCircularlyController.close();
  }
}