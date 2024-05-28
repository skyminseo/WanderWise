import 'package:flutter/material.dart';
import 'package:wander_wise/components/list_tile_layout.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/my_page_screen.dart';

class HomeDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  const HomeDrawer({
    required this.onProfileTap,
    required this.onSignOut,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey[100],
      child: Column(
        children: [
          /// header
          DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.blueGrey,
              size: 64,
            ),
          ),

          /// home list tile
          ListTileLayout(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () {},
          ),

          /// profile list tile
          ListTileLayout(
            icon: Icons.account_circle,
            text: 'P R O F I L E',
            onTap: onProfileTap
          ),

          /// logout list tile
          ListTileLayout(
            icon: Icons.logout_rounded,
            text: 'L O G O U T',
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}
