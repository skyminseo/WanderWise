import 'package:flutter/material.dart';
import 'package:wander_wise/attraction_cards/attractions.dart';

class AttractionCards extends StatelessWidget {
  final Attractions attraction;
  final void Function()? onTap;

  const AttractionCards({
    required this.attraction,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.only(
          bottom: 4,
        ),
        margin: EdgeInsets.only(
          top: 8,
          left: 16,
          bottom: 70,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  attraction.imagePath,
                  height: 160,
                  width: 160,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attraction.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(attraction.price),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.yellow[800],
                            ),
                            Text(
                              attraction.rating,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
