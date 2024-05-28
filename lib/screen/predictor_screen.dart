import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wander_wise/components/custom_appbar.dart';
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
              child: Text('OK'),
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
      appBar: CustomAppBar(title: 'SEARCH FLIGHTS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField(
                value: selectedSourceCity,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSourceCity = newValue!;
                  });
                },
                items: sourceCities.map((city) {
                  return DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Source City'),
              ),
              DropdownButtonFormField(
                value: selectedDestinationCity,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDestinationCity = newValue!;
                  });
                },
                items: destinationCities.map((city) {
                  return DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Destination City'),
              ),
              DropdownButtonFormField(
                value: selectedDepartureTime,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDepartureTime = newValue!;
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem(
                    child: Text(time),
                    value: time,
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Departure Time'),
              ),
              DropdownButtonFormField(
                value: selectedArrivalTime,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedArrivalTime = newValue!;
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem(
                    child: Text(time),
                    value: time,
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Arrival Time'),
              ),
              DropdownButtonFormField(
                value: selectedNumberOfChanges,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedNumberOfChanges = newValue!;
                  });
                },
                items: numberOfChanges.map((change) {
                  return DropdownMenuItem(
                    child: Text(change.toString()),
                    value: change,
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Number of Changes'),
              ),
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: departDateController,
                    decoration: InputDecoration(
                      labelText: 'Departure Date',
                      hintText: 'dd/MM/yyyy',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchPredictions,
                child: Text(
                  'Get Predictions',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}