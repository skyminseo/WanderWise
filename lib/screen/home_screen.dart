import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/screen/predictor_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
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
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 70.0,
            ),
            child: Column(
              children: [
                Text(
                  'Hello! ' + user.email!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _Top(
                  selectedDate: selectedDate,
                  onPressed: onCalendarPressed,
                ),
                _Bottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCalendarPressed() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime.now().add(Duration(days: 1)),
              initialDateTime: DateTime.now().add(Duration(days: 1)),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _Top({
    required this.selectedDate,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'WanderWise',
          ),
          Text(
            'Travel D-Day',
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
            style: textTheme.bodyLarge,
          ),
          IconButton(
            iconSize: 80.0,
            color: Colors.deepOrange[400],
            onPressed: onPressed,
            icon: Icon(
              Icons.calendar_month_rounded,
            ),
          ),
          Text(
            'D-${selectedDate.difference(now).inDays}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ElevatedButton(
            onPressed: () {
              onSettingScreenPressed(context);
            },
            child: Text(
              "Let's make a plan!",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSettingScreenPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PredictorScreen();
        },
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 84.0),
        child: Image.asset('asset/img/plane.png'),
      ),
    );
  }
}
