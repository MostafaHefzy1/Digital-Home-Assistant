import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/local/sharedpreference.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/custom_material_button.dart';
import '../../../../core/shared_component/navigate.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_strings.dart';
import '../../component/show_profile_details.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.profile,
          navigateBack: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                /*         CustomMaterialButton(
                  text: AppStrings.edit,
                  borderRadius: AppColors.foreignColor,
                  background: AppColors.foreignColor,
                  radius: 10,
                  function: () {
                    navigatorTo(context,  EditProfileScreen());
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),*/
                ShowProfileDetailsComponent(
                  labelText: AppStrings.userName,
                  text: CacheHelper.getData(key: "nameUser"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ShowProfileDetailsComponent(
                  labelText: AppStrings.email,
                  text: CacheHelper.getData(key: "email"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomMaterialButton(
                  text: AppStrings.edit,
                  borderRadius: AppColors.foreignColor,
                  background: AppColors.foreignColor,
                  radius: 10,
                  function: () {
                    navigatorTo(context, EditProfileScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
