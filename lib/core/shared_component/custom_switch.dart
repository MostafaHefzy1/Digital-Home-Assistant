import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final Function function;
  final bool isVisible;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;

  const CustomSwitch({
    Key? key,
    required this.function,
    required this.isVisible,
    this.activeColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isVisible,
      onChanged: (value) {
        function();
      },
      activeColor: activeColor,
      inactiveThumbColor: inactiveThumbColor,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
    );
  }
}
