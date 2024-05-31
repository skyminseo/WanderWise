import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wander_wise/components/calendar_banner.dart';
import 'package:wander_wise/components/custom_appbar.dart';
import 'package:wander_wise/resources/color.dart';

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
                ),
              ),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: blueGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                markerDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              eventLoader: (day) {
                final strippedDay = DateTime.utc(day.year, day.month, day.day);
                final events = processedPredictions.containsKey(strippedDay)
                    ? [processedPredictions[strippedDay]]
                    : [];
                return events;
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    final event = events[0] as Map<String, dynamic>;
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
                      bottom: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: markerColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
                    'Price Level: ${prediction?['price_level'] ?? 'N/A'}',
                  ),
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
          color: Colors.grey[350]!,
          width: 4.0,
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
              children: [
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.green,
                    priceStatus: 'Very Low',
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
                Expanded(
                  child: BannerLayout(
                    boxColor: Color(0xffd4c339),
                    priceStatus: 'Slightly Low',
                  ),
                ),
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.orange,
                    priceStatus: 'Slightly High',
                  ),
                ),
                Expanded(
                  child: BannerLayout(
                    boxColor: Colors.red,
                    priceStatus: 'Very High',
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 4,
                top: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good Deal',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Expensive',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                    ),
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
