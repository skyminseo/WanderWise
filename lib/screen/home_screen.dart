import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/screen/predictor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  onCalendarPressed() {
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
                setState(
                  () {
                    selectedDate = date;
                  },
                );
              },
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatefulWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _Top({
    required this.selectedDate,
    required this.onPressed,
    super.key,
  });

  @override
  State<_Top> createState() => _TopState();
}

class _TopState extends State<_Top> {
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
            style: textTheme.displayLarge,
          ),
          Text(
            'Travel D-Day',
            style: textTheme.displayMedium,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            '${widget.selectedDate.year}.${widget.selectedDate.month}.${widget.selectedDate.day}',
            style: textTheme.bodyLarge,
          ),
          IconButton(
            iconSize: 80.0,
            color: Colors.deepOrange[400],
            onPressed: widget.onPressed,
            icon: Icon(
              Icons.calendar_month_rounded,
            ),
          ),
          Text(
            'D-${widget.selectedDate.difference(now).inDays}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ElevatedButton(
            onPressed: onSettingScreenPressed,
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

  onSettingScreenPressed() {
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
