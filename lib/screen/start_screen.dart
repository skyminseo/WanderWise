import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wander_wise/feature_cards/currency_card.dart';
import 'package:wander_wise/feature_cards/flight_card.dart';
import 'package:wander_wise/feature_cards/luggage_card.dart';
import 'package:wander_wise/feature_cards/ticket_card.dart';
import 'package:wander_wise/feature_cards/travel_card.dart';
import 'package:wander_wise/feature_cards/weather_card.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/login_or_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander_wise/screen/register_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    // Check authentication state
    _checkAuthState();

    // Timer for PageView
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (controller.page != null) {
          int currentPage = controller.page!.toInt();
          int nextPage = currentPage + 1;

          if (nextPage > 5) {
            nextPage = 0;
          }

          controller.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCirc,
          );
        }
      },
    );
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.04),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Image.asset(
                'asset/img/wanderwise_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            ClipRRect(
              child: SizedBox(
                height: 400,
                child: PageView(
                  controller: controller,
                  children: const [
                    TicketCard(),
                    WeatherCard(),
                    FlightCard(),
                    LuggageCard(),
                    TravelCard(),
                    CurrencyCard(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SmoothPageIndicator(
              controller: controller,
              count: 6,
              effect: const ExpandingDotsEffect(
                activeDotColor: blueColor,
                dotHeight: 12,
                dotWidth: 12,
                spacing: 8.0,
              ),
            ),
            SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StartButton(
                    buttonContent: 'Get Started',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const LoginOrRegisterScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  _LoginButton(
                    buttonContent: 'I already have an account',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const LoginOrRegisterScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonContent;

  const _StartButton({
    required this.buttonContent,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(buttonContent),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String buttonContent;
  final Function()? onTap;

  const _LoginButton({
    required this.buttonContent,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[50],
        foregroundColor: darkPrimaryColor,
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(buttonContent),
      ),
    );
  }
}
