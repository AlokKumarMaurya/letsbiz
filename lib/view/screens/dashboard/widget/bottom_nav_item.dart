import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final bool isSelected;
  BottomNavItem({@required this.iconData, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ?Colors.black : Colors.transparent
        ),
        child: IconButton(
          icon: Icon(iconData, color: isSelected ?Colors.white : Colors.black, size: 25),
          onPressed: onTap,
        ),
      ),
    );
  }
}
