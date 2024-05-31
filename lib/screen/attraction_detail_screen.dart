import 'package:flutter/material.dart';
import 'package:wander_wise/attraction_cards/attractions.dart';
import 'package:wander_wise/components/button_layout.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/favorites_screen.dart';

// Global list to store favorites
List<Attractions> favoriteAttractions = [];

class AttractionDetailScreen extends StatefulWidget {
  final Attractions attraction;
  final int index;

  const AttractionDetailScreen({
    required this.attraction,
    required this.index,
    super.key,
  });

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteAttractions.contains(widget.attraction);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoriteAttractions.remove(widget.attraction);
      } else {
        favoriteAttractions.add(widget.attraction);
      }
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.attraction.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.grey[900],
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FavoritesScreen(
                      favorites: favoriteAttractions,
                    ),
                  ));
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.attraction.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.attraction.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.attraction.description,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Average Ticket Price",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.attraction.averagePrice,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ButtonLayout(
          onTap: toggleFavorite,
          text: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
          buttonColor: darkBlueColor,
          textColor: Colors.white,
          buttonIcon: isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }
}
