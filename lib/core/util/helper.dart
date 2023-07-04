import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_color.dart';

class MyHelpers {
  // ToDo Show SnackBar
  static showSnackBar(
      {required String message,
      required String status,
      required BuildContext context}) {
    Get.snackbar(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      status == "problem" ? "خطا" : "تبيه",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          status == "problem" ? Colors.redAccent : Colors.lightGreen,
      borderRadius: 10.sp,
      margin: const EdgeInsets.all(15),
      colorText: AppColors.whiteColor,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

}
