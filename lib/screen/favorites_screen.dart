import 'package:flutter/material.dart';
import 'package:wander_wise/attraction_cards/attractions.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/providers/favorites_provider.dart';
import 'package:wander_wise/screen/home_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('My Favorites'),
        actions: [
          IconButton(
            onPressed: () {
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
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final attraction = favorites[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set color inside BoxDecoration
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  attraction.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                attraction.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                attraction.description,
                maxLines: 2, // Limit to two lines
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  ref
                      .read(favoritesProvider.notifier)
                      .removeFavorite(attraction);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
