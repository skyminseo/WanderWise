import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wander_wise/resources/color.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onTabChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      selectedIndex: selectedIndex,
      onTabChange: onTabChange,
      tabs: const [
        GButton(icon: Icons.home, text: 'Home'),
        GButton(icon: Icons.favorite_border, text: 'Community'),
        GButton(icon: Icons.search, text: 'Predictor'),
        GButton(icon: Icons.person, text: 'My Page'),
      ],
      backgroundColor: blueGreyColor,
      color: Colors.white,
      activeColor: Colors.white,
      tabBackgroundColor: darkBlueColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
