import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          style: GoogleFonts.notoSans(
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
