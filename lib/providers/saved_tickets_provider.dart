import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ticket {
  final DateTime date;
  final String departureCity;
  final String destinationCity;
  final int numberOfChanges;

  Ticket({
    required this.date,
    required this.departureCity,
    required this.destinationCity,
    required this.numberOfChanges,
  });
}

class SavedTicketsNotifier extends StateNotifier<List<Ticket>> {
  SavedTicketsNotifier() : super([]);

  void addTicket(Ticket ticket) {
    state = [...state, ticket];
  }

  void removeTicket(Ticket ticket) {
    state = state.where((t) => t != ticket).toList();
  }

  void loadTickets(List<Ticket> tickets) {
    state = tickets;
  }
}

final savedTicketsProvider = StateNotifierProvider<SavedTicketsNotifier, List<Ticket>>((ref) {
  return SavedTicketsNotifier();
});
