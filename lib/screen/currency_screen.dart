import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/providers/currency_provider.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/resources/currency_list.dart';

class CurrencyScreen extends ConsumerStatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends ConsumerState<CurrencyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCurrency = 'USD';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final currencyAsyncValue = ref.watch(currencyProvider(_selectedCurrency));

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
        title: Text('Exchange Rates'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton2<String>(
                  value: _selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrency = newValue!;
                    });
                  },
                  items: currencyList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      labelText: 'Search Currency',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              darkBlueColor, // Change this color to your desired focus color
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: currencyAsyncValue.when(
                data: (currency) {
                  final rates =
                      currency['conversion_rates'] as Map<String, dynamic>;
                  final filteredRates = rates.entries
                      .where((entry) =>
                          entry.key.toLowerCase().contains(_searchQuery))
                      .toList();
                  return ListView(
                    children: [
                      Text('$_selectedCurrency to other currencies:',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      ...filteredRates.map((entry) {
                        return ListTile(
                          title: Text('${entry.key}: ${entry.value}',
                              style: TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ],
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
