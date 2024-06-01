import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/attraction_cards/attractions.dart';

class FavoritesNotifier extends StateNotifier<List<Attractions>> {
  FavoritesNotifier() : super([]);

  void addFavorite(Attractions attraction) {
    state = [...state, attraction];
  }

  void removeFavorite(Attractions attraction) {
    state = state.where((item) => item != attraction).toList();
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Attractions>>((ref) {
  return FavoritesNotifier();
});
