import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/components/home_drawer.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/my_page_screen.dart';
import 'package:wander_wise/screen/predictor_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:wander_wise/screen/community_screen.dart'; // Import CommunityScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => StartScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'asset/img/branding_image.png',
          width: 148,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyPageScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.person,
              size: 28,
            ),
          ),
        ],
      ),
      drawer: HomeDrawer(
        onProfileTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyPageScreen(),
            ),
          );
        },
        onSignOut: () => signUserOut(context),
      ),
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            Expanded(
              child: Column(
                children: [
                  _WelcomeText(),
                  const SizedBox(height: 20),
                  _Plan(),
                  const SizedBox(height: 20),
                  _CommunityButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCommunityPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CommunityScreen(),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  _WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, ' + user.email!.split('@')[0]! + '!',
      style: GoogleFonts.notoSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _Plan extends StatelessWidget {
  const _Plan({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonLayout(
      onTap: () {
        onPredictorScreenPressed(context);
      },
      text: "Let's predict flight prices!",
      buttonColor: blueColor, textColor: Colors.white,
    );
  }

  void onPredictorScreenPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PredictorScreen();
        },
      ),
    );
  }
}

class _CommunityButton extends StatelessWidget {
  const _CommunityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonLayout(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommunityScreen(),
            ),
          );
        },
        text: 'Go to community!',
        buttonColor: darkBlueColor, textColor: Colors.white,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0),
        child: Image.asset('asset/img/wanderwise_logo.png'),
      ),
    );
  }
}
