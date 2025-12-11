import 'dart:async';
import 'dart:math';

class LapCounterService {
  final Stream<double> headingStream;
  int _lapCount = 0;
  double? _startHeading;
  Timer? _cooldownTimer;
  final StreamController<int> _lapController = StreamController<int>.broadcast();

  int get lapCount => _lapCount;
  Stream<int> get lapStream => _lapController.stream;

  LapCounterService(this.headingStream); // يتطلب معاملاً واحداً فقط (الـ stream)

  void start(double initialHeading) {
    _startHeading = initialHeading;
    _lapCount = 0;
    _listenForLaps();
  }

  void _listenForLaps() {
    headingStream.listen((heading) {
      if (_startHeading != null && _cooldownTimer == null) {
        final diff = (heading - _startHeading!).abs();
        final wrappedDiff = min(diff, 360 - diff);
        if (wrappedDiff <= 15) {
          _lapCount++;
          _lapController.add(_lapCount);
          _cooldownTimer = Timer(const Duration(seconds: 5), () => _cooldownTimer = null);
        }
      }
    });
  }

  void reset() {
    _lapCount = 0;
    _startHeading = null;
    _cooldownTimer?.cancel();
    _cooldownTimer = null;
    _lapController.add(_lapCount);
  }

  void dispose() {
    _cooldownTimer?.cancel();
    _lapController.close();
  }
}