import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/custom_networkimage.dart';
import '../../../../core/shared_component/navigate.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_images.dart';
import '../../../../core/util/app_strings.dart';
import '../../component/card_component.dart';
import 'confrim_location.dart';
import 'devices_screen.dart';
import 'profile_screen.dart';
import 'send_email_screen.dart';

import 'add_calendar_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.setting,
        icon: Icons.settings,
        navigateBack: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CardComponent(
                leadingText: AppStrings.profile,
                icon: CustomNetworkImage(
                    image: AppImages.profileImage, height: 50.h),
                function: () {
                  navigatorTo(context, const ProfileScreen());
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CardComponent(
                leadingText: AppStrings.devices,
                icon:
                    const Icon(Icons.tv, color: AppColors.whiteColor, size: 50),
                function: () {
                  navigatorTo(context, const DevicesScreen());
                },
              ),
/*              SizedBox(
                height: 20.h,
              ),
              CardComponent(
                leadingText: AppStrings.history,
                icon: const Icon(Icons.file_open_outlined,
                    color: AppColors.whiteColor, size: 50),
                function: () {
                  // todo:navigate to date
                },
              ),*/
              /*       SizedBox(
                height: 20.h,
              ),
              CardComponent(
                leadingText: AppStrings.rooms,
                icon: const Icon(Icons.roofing,
                    color: AppColors.whiteColor, size: 50),
                function: () {
                  // todo:navigate to rooms
                },
              ),*/
              SizedBox(
                height: 20.h,
              ),
              CardComponent(
                leadingText: "التقويم",
                icon: const Icon(FontAwesomeIcons.calendarDays,
                    color: AppColors.whiteColor, size: 50),
                function: () {
                  navigatorTo(context, AddCalendar());
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CardComponent(
                leadingText: "البريد إلكتروني",
                icon: const Icon(Icons.email,
                    color: AppColors.whiteColor, size: 50),
                function: () {
                  navigatorTo(context, SendEmail());
                },
              ),
              // CardComponent(
              //   leadingText: "الموقع",
              //   icon: const Icon(Icons.location_on_outlined,
              //       color: AppColors.whiteColor, size: 50),
              //   function: () {
              //     navigatorTo(context, ConfrimLocation());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
