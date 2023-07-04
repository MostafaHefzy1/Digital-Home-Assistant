import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/app_color.dart';

class CardComponent extends StatelessWidget {
  const CardComponent(
      {Key? key,
      required this.leadingText,
      required this.icon,
      required this.function})
      : super(key: key);
  final String leadingText;
  final Widget icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                leadingText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 11.sp),
              ),
            ),
            const Spacer(),
            Expanded(
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
