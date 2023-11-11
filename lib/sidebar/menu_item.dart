import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color iconColor = Colors.white;
Color textColor = Colors.white;

class MenuItems extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final void Function()? onTap;
  final Color? textColor; // Add a textColor parameter

  const MenuItems({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
    this.textColor, // Initialize the textColor parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white, // Set a default color for the icon
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title!,
                style: GoogleFonts.notoSerifYezidi(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: textColor ?? Colors.white, // Use the provided textColor or default to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
