import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/custom_form_field.dart';
import '../../../../core/shared_component/custom_material_button.dart';
import '../../../../core/shared_component/custom_networkimage.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_images.dart';
import '../../../../core/util/app_strings.dart';
import '../../component/label_text.dart';

import '../../../../core/network/local/sharedpreference.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = CacheHelper.getData(key: "nameUser");
    _emailController.text = CacheHelper.getData(key: "email");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.editProfile,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelTextComponent(
                  text: AppStrings.userName,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomFormField(
                    type: TextInputType.name,
                    controller: _nameController,
                    validate: (value) {},
                    text: AppStrings.userName,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const LabelTextComponent(
                  text: AppStrings.email,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomFormField(
                    type: TextInputType.emailAddress,
                    controller: _emailController,
                    validate: (value) {},
                    text: AppStrings.email,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: CustomMaterialButton(
                    text: AppStrings.done,
                    borderRadius: AppColors.foreignColor,
                    background: AppColors.foreignColor,
                    radius: 10,
                    width: 110.w,
                    function: () {
                      //todo: update profile
                      CacheHelper.saveData(
                          key: "nameUser", value: _nameController.text);
                      CacheHelper.saveData(
                          key: "email", value: _emailController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
