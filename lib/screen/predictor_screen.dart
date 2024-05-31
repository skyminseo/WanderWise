import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/components/custom_appbar.dart';
import 'package:wander_wise/components/searchable_dropdown.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/resources/destination_cities.dart';
import 'package:wander_wise/resources/source_cities.dart';
import 'calendar_screen.dart';

class PredictorScreen extends StatefulWidget {
  @override
  _PredictorScreenState createState() => _PredictorScreenState();
}

class _PredictorScreenState extends State<PredictorScreen> {
  final TextEditingController departDateController = TextEditingController();

  String selectedSourceCity = sourceCities.first;
  String selectedDestinationCity = destinationCities.first;
  String selectedDepartureTime = 'Morning';
  String selectedArrivalTime = 'Afternoon';
  int selectedNumberOfChanges = 0;
  DateTime selectedDepartureDate = DateTime.now();

  List<String> times = ['Morning', 'Afternoon', 'Evening', 'Night'];
  List<int> numberOfChanges = [0, 1, 2, 3];

  @override
  void initState() {
    super.initState();
    departDateController.text = "${selectedDepartureDate.day}"
        "/${selectedDepartureDate.month}"
        "/${selectedDepartureDate.year}";
  }

  Future<void> fetchPredictions() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blueGrey,
            color: primaryColor,
            strokeWidth: 8.0,
          ),
        );
      },
    );

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8001/predict'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'source_city': selectedSourceCity,
          'destination_city': selectedDestinationCity,
          'departure_time': selectedDepartureTime,
          'arrival_time': selectedArrivalTime,
          'depart_date': departDateController.text,
          'number_of_changes': selectedNumberOfChanges,
        }),
      );

      Navigator.of(context).pop(); // Dismiss the loading indicator

      if (response.statusCode == 200) {
        List<dynamic> predictionList = jsonDecode(response.body);
        Map<String, dynamic> predictions = {
          for (var p in predictionList) p['date']: p
        };
        print('Predictions received: $predictions'); // Debug statement
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalendarScreen(
              predictions: predictions,
              focusedDay: DateTime.parse(
                  predictionList.first['date']), // set focusedDay
            ),
          ),
        );
      } else {
        print(
            'Failed to load predictions. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Dismiss the loading indicator in case of error
      print('Exception caught: $e');
      throw Exception('Failed to load predictions');
    }
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 350,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: CupertinoDatePicker(
                  initialDateTime: selectedDepartureDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      selectedDepartureDate = newDateTime;
                      departDateController.text =
                          "${newDateTime.day}/${newDateTime.month}/${newDateTime.year}";
                    });
                  },
                ),
              ),
            ),
            CupertinoButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Ticket Prices Prediction',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'asset/img/flight.png',
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.grey[900],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      'Choose Your Travel Preferences',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: SearchableDropdown<String>(
                              labelText: 'Source City',
                              selectedValue: selectedSourceCity,
                              items: sourceCities,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSourceCity = newValue!;
                                });
                              },
                              boxColor: darkPrimaryColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: SearchableDropdown<String>(
                              labelText: 'Destination City',
                              selectedValue: selectedDestinationCity,
                              items: destinationCities,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDestinationCity = newValue!;
                                });
                              },
                              boxColor: darkPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SearchableDropdown<String>(
                              labelText: 'Departure Time',
                              selectedValue: selectedDepartureTime,
                              items: times,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDepartureTime = newValue!;
                                });
                              },
                              boxColor: blueColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: SearchableDropdown<String>(
                              labelText: 'Arrival Time',
                              selectedValue: selectedArrivalTime,
                              items: times,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedArrivalTime = newValue!;
                                });
                              },
                              boxColor: blueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SearchableDropdown<int>(
                              labelText: 'Number of Changes',
                              selectedValue: selectedNumberOfChanges,
                              items: numberOfChanges,
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedNumberOfChanges = newValue!;
                                });
                              },
                              boxColor: darkBlueColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => _showDatePicker(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: darkBlueColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Departure Date',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              departDateController.text,
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.calendar_month_rounded,
                                            size: 40,
                                            color: Colors.grey[800],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                    ),
                    SizedBox(height: 16),
                    ButtonLayout(
                      onTap: fetchPredictions,
                      text: 'Get Predictions!',
                      buttonColor: Colors.transparent,
                      textColor: Colors.grey[800]!,
                      buttonIcon: Icons.arrow_forward_ios_rounded,
                      border: Border.all(
                        color: darkBlueColor,
                        width: 4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
