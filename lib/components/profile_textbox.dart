import 'package:flutter/material.dart';
import 'package:wander_wise/resources/color.dart';

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
        color: blueGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
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
                  color: Colors.grey[600],
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: icons,
                color: Colors.grey[600],
              ),
            ],
          ),

          // text
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
