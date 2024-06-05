import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/providers/saved_tickets_provider.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/predictor_screen.dart';
import 'package:wander_wise/screen/weather_forecast_screen.dart';

class SavedTicketScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedTickets = ref.watch(savedTicketsProvider);
    final savedTicketsNotifier = ref.watch(savedTicketsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Saved Tickets'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: savedTickets.length,
                itemBuilder: (context, index) {
                  String formattedDate =
                      DateFormat("yMMMMd").format(savedTickets[index].date);
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '${savedTickets[index].departureCity} to ${savedTickets[index].destinationCity}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Departure Date: $formattedDate\n'
                        'Number of Changes: ${savedTickets[index].numberOfChanges}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => savedTicketsNotifier
                            .removeTicket(savedTickets[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          BottomAppBar(
            height: 180,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Column(
                children: [
                  ButtonLayout(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PredictorScreen(),
                        ),
                      );
                    },
                    text: 'Predict other flights!',
                    buttonColor: darkBlueColor,
                    textColor: Colors.white,
                    buttonIcon: Icons.airplane_ticket_rounded,
                  ),
                  SizedBox(height: 8),
                  ButtonLayout(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WeatherForecastScreen(),
                        ),
                      );
                    },
                    text: 'Check Destination Weather!',
                    buttonColor: Colors.teal,
                    textColor: Colors.white,
                    buttonIcon: Icons.sunny_snowing,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
