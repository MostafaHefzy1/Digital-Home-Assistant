import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.navigateBack = true,
      this.wantIcon = true,
      this.icon});

  final String title;
  final bool navigateBack;
  final bool wantIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: navigateBack != false
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontSize: 16.sp, color: AppColors.whiteColor),
          ),
          wantIcon != false
              ? SizedBox(
                  width: 10.w,
                )
              : const SizedBox(),
          wantIcon != false
              ? Icon(
                  icon,
                  color: AppColors.whiteColor,
                  size: 40.sp,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class CustomAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarTwo({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
