import 'package:flutter/material.dart';

Color iconColor = Colors.white;
Color textColor = Colors.white;


class MenuItems extends StatelessWidget {

  final IconData? icon;
  final String? title;
  final void Function()? onTap;

  const MenuItems({Key? key, this.icon, this.title, this.onTap}) : super(key: key);

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
                color: iconColor,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: textColor
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}
