import 'package:flutter/material.dart';
import '../util/app_color.dart';

class CustomTextButton extends StatelessWidget {
  final Function function;
  final String text;
  final Color? color;

  const CustomTextButton({
    super.key,
    required this.function,
    required this.text,
    this.color= AppColors.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: TextStyle( color: color,fontSize: 15),
      ),
    );
  }
}
