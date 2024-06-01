import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/predictor_screen.dart';

class SavedTicketScreen extends StatefulWidget {
  final List<DateTime> selectedDates;
  final String departureCity;
  final String destinationCity;
  final int selectedNumberOfChanges;

  SavedTicketScreen({
    required this.selectedDates,
    required this.departureCity,
    required this.destinationCity,
    required this.selectedNumberOfChanges,
  });

  @override
  _SavedTicketScreenState createState() => _SavedTicketScreenState();
}

class _SavedTicketScreenState extends State<SavedTicketScreen> {
  late List<DateTime> selectedDates;

  @override
  void initState() {
    super.initState();
    selectedDates = widget.selectedDates;
  }

  void deleteTicket(int index) {
    setState(() {
      selectedDates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).maybePop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Saved Tickets'),
      ),
      body: Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: selectedDates.length,
                itemBuilder: (context, index) {
                  String formattedDate =
                      DateFormat("yMMMMd").format(selectedDates[index]);
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '${widget.departureCity} to ${widget.destinationCity}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Departure Date: $formattedDate\n'
                        'Number of Changes: ${widget.selectedNumberOfChanges}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTicket(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
