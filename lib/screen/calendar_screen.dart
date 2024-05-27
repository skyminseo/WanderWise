import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wander_wise/components/calendar_banner.dart';
import 'package:wander_wise/components/custom_appbar.dart';

class CalendarScreen extends StatelessWidget {
  final Map<String, dynamic> predictions;
  final DateTime focusedDay;

  CalendarScreen({required this.predictions, required this.focusedDay});

  @override
  Widget build(BuildContext context) {
    // Process the predictions to map them to the correct date format
    Map<DateTime, Map<String, dynamic>> processedPredictions = {};
    predictions.forEach((key, value) {
      // Parse the date string and create a DateTime object
      DateTime date = DateTime.parse(key).toUtc();
      processedPredictions[date] = value;
    });

    // Check if predictions are processed correctly
    print(
        'Processed Predictions: $processedPredictions'); // Debug statement to print the processed predictions

    return Scaffold(
      appBar: CustomAppBar(title: 'FLIGHT PRICE CALENDAR'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  )),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                final strippedDay = DateTime.utc(day.year, day.month, day.day);
                final events = processedPredictions.containsKey(strippedDay)
                    ? [processedPredictions[strippedDay]]
                    : [];
                print('Events for $strippedDay: $events'); // Debug statement
                return events;
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    final event = events[0] as Map<String, dynamic>;
                    print(
                        'Building marker for $date: $event'); // Debug statement
                    Color markerColor;
                    switch (event['price_level']) {
                      case 'very high':
                        markerColor = Colors.red;
                        break;
                      case 'slightly high':
                        markerColor = Colors.orange;
                        break;
                      case 'slightly low':
                        markerColor = Color(0xffd4cf39);
                        break;
                      case 'very low':
                        markerColor = Colors.green;
                        break;
                      default:
                        markerColor = Colors.grey;
                    }
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: markerColor,
                          shape: BoxShape.circle,
                        ),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: _Banner(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: processedPredictions.length,
              itemBuilder: (context, index) {
                final date = processedPredictions.keys.elementAt(index);
                final prediction = processedPredictions[date];
                return ListTile(
                  title: Text(
                    '${date.year}. ${date.month}. ${date.day}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                      'Price Level: ${prediction?['price_level'] ?? 'N/A'}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.red,
                    priceStatus: 'Very High',
                  ),
                ),
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.orange,
                    priceStatus: 'Slightly High',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: BannerLayout(
                    boxColor: Color(0xffd4c339),
                    priceStatus: 'Slightly Low',
                  ),
                ),
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.green,
                    priceStatus: 'Very Low',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
