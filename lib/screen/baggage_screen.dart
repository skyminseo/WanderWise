import 'package:flutter/material.dart';
import 'package:wander_wise/resources/airlines_list.dart';
import 'package:wander_wise/resources/baggage_data.dart';
import 'package:wander_wise/resources/color.dart';

class BaggageScreen extends StatefulWidget {
  const BaggageScreen({Key? key}) : super(key: key);

  @override
  _BaggageScreenState createState() => _BaggageScreenState();
}

class _BaggageScreenState extends State<BaggageScreen> {
  String? _selectedAirline;
  String? _selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        centerTitle: true,
        title: Text('Check Baggage Allowance'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: Text('Select Airline'),
                  value: _selectedAirline,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAirline = newValue;
                      _selectedClass =
                          null; // Reset class selection when airline changes
                    });
                  },
                  items: airlinesList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                if (_selectedAirline != null)
                  DropdownButton<String>(
                    hint: Text('Select Class'),
                    value: _selectedClass,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedClass = newValue;
                      });
                    },
                    items: baggageAllowance[_selectedAirline!]!
                        .keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
              ],
            ),
            SizedBox(height: 20),
            if (_selectedAirline != null && _selectedClass != null)
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    children: [
                      Text('Baggage Allowance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Allowance']!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 24),
                      Text('Liquids',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Liquids']!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 24),
                      Text('Sharp Objects',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Sharp Objects']!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 24),
                      Text('Electronics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Electronics']!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 24),
                      Text('Prohibited Items',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Prohibited Items']!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 24),
                      Text('Special Items',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        baggageAllowance[_selectedAirline!]![_selectedClass!]![
                            'Special Items']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
