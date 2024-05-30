import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_wise/auth/auth_page.dart';
import 'package:wander_wise/screen/community_screen.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/login_screen.dart';
import 'package:wander_wise/screen/my_page_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.notoSans(),
        ),
      ),
      home: StartScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/start': (context) => StartScreen(),
        '/community': (context) => CommunityScreen(),
        '/mypage': (context) => MyPageScreen(),
      },
    ),
  );
}
