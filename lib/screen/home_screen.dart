import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/screen/predictor_screen.dart';
import 'package:wander_wise/screen/my_page_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyPageScreen(),
                ),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            Text(
              'Hello! ' + user.email!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            _Plan(
              selectedDate: selectedDate,
              onPressed: onCalendarPressed,
            ),
          ],
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

class _Plan extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _Plan({
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
          ElevatedButton(
            onPressed: () {
              onSettingScreenPressed(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[50],
              foregroundColor: Colors.blueGrey,
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Text(
              "Let's make a plan!",
            ),
          ),
          Column(
            children: [
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
            ],
          )
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
