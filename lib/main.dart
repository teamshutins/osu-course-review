// Implementation of main() function.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Taka: This is for the responsive design.
  // The app should work regarless of the device screen orientation (either portrait or landscape mode).
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  // Taka: Refers to app.dart file
  runApp(App());
}
