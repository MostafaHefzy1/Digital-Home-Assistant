import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeze_mobile/core/shared_component/custom_appbar.dart';

import '../../../../core/shared_component/custom_form_field.dart';
import '../../../../core/shared_component/custom_material_button.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_strings.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class SendEmail extends StatelessWidget {
  SendEmail({super.key});
  final TextEditingController _subjectEmailController = TextEditingController();

  final TextEditingController _bodyEmailController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var homecubit = HomeCubit.get(context);
        return SafeArea(
            child: Scaffold(
              appBar: CustomAppBarTwo(title: "البريد إلكتروني"),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor , width: 1.5),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomFormField(
                      type: TextInputType.visiblePassword,
                      isPassword: false,
                      controller: _emailController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.requiredField;
                        }
                        return null;
                      },
                      text: "البريد إلكتروني",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor , width: 1.5),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomFormField(
                      type: TextInputType.text,
                      controller: _subjectEmailController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.requiredField;
                        }
                        return null;
                      },
                      text: "عنوان البريد الإلكتروني",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor , width: 1.5),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomFormField(
                      type: TextInputType.visiblePassword,
                      isPassword: false,
                      controller: _bodyEmailController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.requiredField;
                        }
                        return null;
                      },
                      text: "موضوع البريد الإلكتروني",
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomMaterialButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        homecubit.sendEmailLauncher(
                            emailSender: _emailController.text,
                            subjectEmail: _subjectEmailController.text,
                            bodyEmail: _bodyEmailController.text);
                      }
                    },
                    text: "ارسل البريد الكتروني",
                    borderRadius: AppColors.foreignColor,
                    background: AppColors.foreignColor,
                    radius: 10,
                    textStyle: true,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
