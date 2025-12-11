import 'package:flutter_tts/flutter_tts.dart';

class VoiceAnnouncer {
  final FlutterTts _tts = FlutterTts();

  VoiceAnnouncer() {
    _init();
  }

  void _init() async {
    await _tts.setLanguage('ar');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
  }

  Future<void> announceLap(int lapNumber) async {
    final text = 'تم احتساب الشوط رقم $lapNumber';
    await _tts.speak(text);
  }

  void dispose() {
    _tts.stop();
  }
}