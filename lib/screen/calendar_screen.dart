import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/components/calendar_banner.dart';
import 'package:wander_wise/resources/color.dart';
import 'saved_ticket_screen.dart';
import 'package:wander_wise/providers/saved_tickets_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> predictions;
  final DateTime focusedDay;
  final String departureCity;
  final String destinationCity;
  final DateTime departureDate; // Added departure date
  final int selectedNumberOfChanges;

  CalendarScreen({
    required this.predictions,
    required this.focusedDay,
    required this.departureCity,
    required this.destinationCity,
    required this.departureDate, // Added departure date
    required this.selectedNumberOfChanges,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  List<DateTime> selectedPreferredDates = [];

  Map<String, List<DateTime>> groupedDatesByMonth(
      Map<DateTime, Map<String, dynamic>> predictions) {
    Map<String, List<DateTime>> groupedDates = {};

    predictions.forEach((date, value) {
      String monthKey = DateFormat("MMMM y").format(date);
      if (!groupedDates.containsKey(monthKey)) {
        groupedDates[monthKey] = [];
      }
      groupedDates[monthKey]!.add(date);
    });

    return groupedDates;
  }

  @override
  Widget build(BuildContext context) {
    // Process the predictions to map them to the correct date format
    Map<DateTime, Map<String, dynamic>> processedPredictions = {};
    widget.predictions.forEach((key, value) {
      // Parse the date string and create a DateTime object
      DateTime date = DateTime.parse(key).toUtc();
      processedPredictions[date] = value;
    });

    // Filter the processed predictions to include those with a "very low" or "slightly low" price level
    Map<DateTime, Map<String, dynamic>> recommendedPricePredictions = {};
    processedPredictions.forEach((key, value) {
      if (value['price_level'] == 'very low' ||
          value['price_level'] == 'slightly low') {
        recommendedPricePredictions[key] = value;
      }
    });

    // Group the dates by month
    Map<String, List<DateTime>> groupedDates =
    groupedDatesByMonth(recommendedPricePredictions);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: darkBlueColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
            title: Row(
              children: [
                Text(
                  '${widget.departureCity} ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.airplanemode_active_rounded,
                ),
                Text(
                  ' ${widget.destinationCity}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.airplane_ticket_rounded,
                  size: 32,
                ),
                onPressed: () {
                  if (selectedPreferredDates.isNotEmpty) {
                    ref.read(savedTicketsProvider.notifier).loadTickets(
                      selectedPreferredDates.map((date) {
                        return Ticket(
                          date: date,
                          departureCity: widget.departureCity,
                          destinationCity: widget.destinationCity,
                          numberOfChanges: widget.selectedNumberOfChanges,
                        );
                      }).toList(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedTicketScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select at least one date'),
                      ),
                    );
                  }
                },
              ),
            ],
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                child: _AppbarText(
                  departureCity: widget.departureCity,
                  destinationCity: widget.destinationCity,
                  departureDate: widget.departureDate, // Pass departure date
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TableCalendar(
                focusedDay: widget.focusedDay,
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
                  final strippedDay =
                  DateTime.utc(day.year, day.month, day.day);
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: _Banner(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20,
              ),
              child: Text(
                'I recommend buying tickets on these dates!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ...groupedDates.entries.map((entry) {
            final month = entry.key;
            final dates = entry.value;
            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 20,
                      top: 20,
                    ),
                    child: Text(
                      month,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 100, // Set a fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (BuildContext context, int index) {
                        final date = dates[index];
                        final prediction = recommendedPricePredictions[date];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedPreferredDates.contains(date)) {
                                selectedPreferredDates.remove(date);
                              } else {
                                selectedPreferredDates.add(date);
                              }
                            });
                          },
                          child: Container(
                            width: 180, // Set a fixed width for each item
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text(
                                  '${date.year}. ${date.month}. ${date.day}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  'Ticket Price: ${prediction!['price_level']}',
                                ),
                                trailing: Icon(
                                  selectedPreferredDates.contains(date)
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: selectedPreferredDates.contains(date)
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
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

class _AppbarText extends StatelessWidget {
  final String departureCity;
  final String destinationCity;
  final DateTime departureDate;

  _AppbarText({
    required this.departureCity,
    required this.destinationCity,
    required this.departureDate,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the departure date 10 months later
    DateTime selectedDepartureDate = DateTime(
      departureDate.year,
      departureDate.month,
      departureDate.day,
    );

    DateTime lastPredictedDate = DateTime(
      departureDate.year,
      departureDate.month + 10,
      departureDate.day,
    );

    // Format the new departure date to "July 17"
    String firstFormattedDate =
    DateFormat("yMMMMd").format(selectedDepartureDate);
    String lastFormattedDate = DateFormat("yMMMMd").format(lastPredictedDate);

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    margin: EdgeInsets.only(
                      left: 60,
                      right: 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flight_takeoff_rounded,
                                size: 28,
                                color: Colors.grey[800],
                              ),
                              SizedBox(width: 16),
                              Text(
                                '$departureCity',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flight_land_rounded,
                                size: 28,
                                color: Colors.grey[800],
                              ),
                              SizedBox(width: 20),
                              Text(
                                '$destinationCity',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '$firstFormattedDate - $lastFormattedDate',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
