
import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({
    super.key,
    required this.icon,
    required this.toolTip,
    required this.onPressed,
  });

  final IconData icon;
  final String toolTip;
  final void Function() onPressed;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.lightBlue,
      tooltip: toolTip,
      enableFeedback: true,
      icon: Icon(
        icon,
        color: Colors.lightBlue,
      ),
      onPressed: onPressed,
    );
  }
}