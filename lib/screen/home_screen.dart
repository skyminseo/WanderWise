import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_wise/attraction_cards/attraction_cards.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/components/home_drawer.dart';
import 'package:wander_wise/resources/attractions_list.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/attraction_detail_screen.dart';
import 'package:wander_wise/screen/my_page_screen.dart';
import 'package:wander_wise/screen/predictor_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';
import 'package:wander_wise/screen/community_screen.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: blueGreyColor,
            pinned: true,
            floating: true,
            expandedHeight: 230.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _WelcomeText(),
              title: Image.asset(
                'asset/img/branding_image.png',
                width: 148,
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 16.0),
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
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
                child: Container(
                  color: Colors
                      .grey[50], // Ensure the color matches the background
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      _FeatureTitle(),
                      _PredictorButton(),
                      SizedBox(height: 10),
                      _CommunityButton(),
                      SizedBox(height: 30),
                      _PopularTitle(),
                      _Attractions(),
                      _PopularTitle(),
                      _Attractions(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ], color: blueGreyColor, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Hello, ',
                      style: GoogleFonts.notoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      user.email!.split('@')[0]! + '!' + ' 👋',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: blueColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'WanderWise!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: darkBlueColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _Logo(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/img/edit_logo.png',
      width: 100,
      height: 100,
    );
  }
}

class _FeatureTitle extends StatelessWidget {
  const _FeatureTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, bottom: 16),
      child: Text(
        'Features',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}

class _PopularTitle extends StatelessWidget {
  const _PopularTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, bottom: 12),
      child: Text(
        'Popular',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.grey[800],
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

class _Attractions extends StatefulWidget {
  const _Attractions({super.key});

  @override
  State<_Attractions> createState() => _AttractionsState();
}

class _AttractionsState extends State<_Attractions> {
  List attractionMenu = attractions;

  void navigateToAttractionDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttractionDetailScreen(
          index: index,
          attraction: attractionMenu[index],
        ), // Pass the index here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 305,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attractions.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              navigateToAttractionDetails(index), // Navigate with index
          child: AttractionCards(
            attraction: attractionMenu[index],
          ),
        ),
      ),
    );
  }
}
