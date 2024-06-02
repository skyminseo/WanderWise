import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<dynamic>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<dynamic>> {
  FavoritesNotifier() : super([]);

  void addFavorite(dynamic item) {
    state = [...state, item];
  }

  void removeFavorite(dynamic item) {
    state = state.where((element) => element != item).toList();
  }
}
