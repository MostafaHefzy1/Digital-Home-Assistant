import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/shared_component/navigate.dart';
import '../../core/util/app_color.dart';
import '../../core/util/app_images.dart';
import '../../core/util/app_strings.dart';

import '../../../core/network/local/sharedpreference.dart';
import '../../../smart_home/presentation/screen/bottom_nav_bat.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    if (CacheHelper.getData(key: "token") == null) {
      navigatorAndRemove(context, const LoginScreen());
    } else {
      navigatorAndRemove(context, const BottomNavigatorBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              AppImages.splashScreenImage,
            )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.smartHome,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 30.sp,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            )
          ],
        ),
      ),
    );
  }
}
