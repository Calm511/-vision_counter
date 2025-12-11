import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/tawaf_counter_screen.dart';

void main() {
  runApp(ProviderScope(child: TawafCounterApp()));
}

class TawafCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TawafCounterScreen());
  }
}