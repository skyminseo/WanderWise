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
            title: Text(attraction.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),),
            subtitle: Text(
              attraction.description,
              maxLines: 2,  // Limit to two lines
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600]
              ),
            ),
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
