import 'package:flutter/material.dart';
import 'package:wander_wise/components/text_theme.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
