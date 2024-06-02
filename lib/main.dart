import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/community_screen.dart';
import 'package:wander_wise/screen/my_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    // Load environment variables
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading .env file: $e');
  }

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/start': (context) => StartScreen(),
          '/community': (context) => CommunityScreen(),
          '/mypage': (context) => MyPageScreen(),
        },
      ),
    ),
  );
}
