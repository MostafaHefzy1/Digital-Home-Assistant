import 'package:flutter/material.dart';

import '../util/app_color.dart';

class CustomMaterialButton extends StatelessWidget {
  final double? width;
  final Color? background;
  final Function function;
  final String text;
  final double? radius;
  final Color borderRadius;
  final bool textStyle;
  const CustomMaterialButton({
    super.key,
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.background ,
    this.radius = 30,
    required this.borderRadius,
    this.textStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        border: Border.all(
          color: borderRadius,
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style:textStyle == false?  Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppColors.whiteColor):
          Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
