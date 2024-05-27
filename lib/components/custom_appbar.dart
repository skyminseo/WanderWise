import 'package:flutter/material.dart';
import 'package:wander_wise/resources/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.automaticallyImplyLeading = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person,
            size: 28.0,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
