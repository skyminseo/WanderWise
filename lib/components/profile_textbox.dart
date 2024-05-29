import 'package:flutter/material.dart';

class ProfileTextbox extends StatelessWidget {
  final String content;
  final String sectionName;
  final void Function()? onPressed;
  final Icon icons;

  const ProfileTextbox({
    required this.content,
    required this.sectionName,
    required this.onPressed,
    required this.icons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 16,
        bottom: 16,
      ),
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: icons,
                color: Colors.grey[500],
              ),
            ],
          ),

          // text
          Text(
            content,
          ),
        ],
      ),
    );
  }
}
