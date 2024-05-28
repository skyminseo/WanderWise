import 'package:flutter/material.dart';
import 'package:wander_wise/auth/auth_page.dart';
import 'package:wander_wise/components/text_theme.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: textTheme,
      home: StartScreen(),
    ),
  );
}
