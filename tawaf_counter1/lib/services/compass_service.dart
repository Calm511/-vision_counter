import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:stream_transform/stream_transform.dart';

class CompassService extends ChangeNotifier {
  double _heading = 0.0;
  final StreamController<double> _headingController = StreamController<double>.broadcast();
  StreamSubscription<CompassEvent>? _subscription;

  double get heading => _heading;
  Stream<double> get headingStream => _headingController.stream; // إضافة هذا

  void start() {
    if (FlutterCompass.events != null) {
      _subscription = FlutterCompass.events!
          .throttle(const Duration(milliseconds: 200))
          .listen((event) {
        if (event.heading != null) {
          _heading = event.heading!;
          _headingController.add(_heading); // إرسال التحديث إلى الـ stream
          notifyListeners();
        }
      });
    } else {
      _heading = 0.0;
      _headingController.add(_heading);
      notifyListeners();
    }
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    stop();
    _headingController.close(); // إغلاق الـ controller
    super.dispose();
  }
}