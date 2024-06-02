import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final currencyProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, standardCurrency) async {
  final apiKey = dotenv.env['CURRENCY_API_KEY'];
  if (apiKey == null) {
    throw Exception('CURRENCY_API_KEY not found in environment variables');
  }
  final response = await http.get(Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/$standardCurrency'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load currency data');
  }
});

class CurrencySearchNotifier extends StateNotifier<String> {
  CurrencySearchNotifier() : super('');

  void setSearchQuery(String query) {
    state = query;
  }
}

final currencySearchProvider = StateNotifierProvider<CurrencySearchNotifier, String>((ref) {
  return CurrencySearchNotifier();
});
