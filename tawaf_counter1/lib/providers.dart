import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/compass_service.dart';
import 'services/sensor_service.dart';
import 'services/circular_motion_detector.dart';
import 'services/lap_counter_service.dart';
import 'services/voice_announcer.dart';

final compassProvider = ChangeNotifierProvider<CompassService>((ref) => CompassService());
final sensorProvider = Provider<SensorService>((ref) => SensorService());
final circularMotionProvider = Provider<CircularMotionDetector>((ref) {
  final compass = ref.watch(compassProvider);
  final sensor = ref.watch(sensorProvider);
  return CircularMotionDetector(compass.headingStream, sensor.accelerometer);
});
final lapProvider = Provider<LapCounterService>((ref) { // غيّر إلى Provider عادي
  final compass = ref.watch(compassProvider);
  return LapCounterService(compass.headingStream); // تمرير الـ stream الصحيح
});
final voiceProvider = Provider<VoiceAnnouncer>((ref) => VoiceAnnouncer());