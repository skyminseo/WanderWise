import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_wise/attraction_cards/attraction_cards.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/components/home_drawer.dart';
import 'package:wander_wise/resources/attractions_list.dart';
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

  List attractionMenu = attractions;

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
        backgroundColor: Colors.transparent,
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
      backgroundColor: blueGreyColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WelcomeText(),
            const _Logo(),
            Padding(
              padding: EdgeInsets.only(left: 32, bottom: 16),
              child: Text(
                'F E A T U R E S',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _PredictorButton(),
            SizedBox(height: 10),
            _CommunityButton(),

            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 32, bottom: 16),
              child: Text(
                'P O P U L A R',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 305, // Set a height to ensure the ListView.builder is constrained
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attractions.length,
                itemBuilder: (context, index) => AttractionCards(
                  attraction: attractionMenu[index],
                ),
              ),
            ),
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
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Center(
        child: Text(
          'Hello, ' + user.email!.split('@')[0]! + '!',
          style: GoogleFonts.notoSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _PredictorButton extends StatelessWidget {
  const _PredictorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonLayout(
      onTap: () {
        onPredictorScreenPressed(context);
      },
      text: "Let's predict flight prices!",
      buttonColor: blueColor,
      textColor: Colors.white,
      buttonIcon: Icons.airplane_ticket,
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
        buttonColor: darkBlueColor,
        textColor: Colors.white,
        buttonIcon: Icons.message_rounded,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
      child: Image.asset('asset/img/wanderwise_logo.png'),
    );
  }
}
