import 'package:flutter/material.dart';

class ListTileLayout extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const ListTileLayout({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[600],
        ),
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
