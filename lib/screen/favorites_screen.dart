import 'package:flutter/material.dart';
import 'package:wander_wise/attraction_cards/attractions.dart';
import 'package:wander_wise/components/custom_appbar.dart';
import 'package:wander_wise/resources/color.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Attractions> favorites;

  FavoritesScreen({required this.favorites});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Favorites'),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final attraction = widget.favorites[index];
          return ListTile(
            leading: Image.asset(attraction.imagePath, fit: BoxFit.cover),
            title: Text(attraction.name),
            subtitle: Text(attraction.description),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  widget.favorites.remove(attraction);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
