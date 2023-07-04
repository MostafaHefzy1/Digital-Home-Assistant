import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/show_loading_indicator_f.unction.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/helper.dart';

import '../../../../core/network/local/sharedpreference.dart';
import '../../../../core/shared_component/custom_form_field.dart';
import '../../../../core/shared_component/custom_material_button.dart';
import '../../../../core/util/app_strings.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class AddDevicesScreen extends StatefulWidget {
  const AddDevicesScreen({super.key});

  @override
  State<AddDevicesScreen> createState() => _AddDevicesScreenState();
}

class _AddDevicesScreenState extends State<AddDevicesScreen> {
  final formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is CreateProductLoadingState) {
          showLoadingIndicator(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: const CustomAppBarTwo(
              title: AppStrings.addDevices,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                cubit.pickedFiles != null
                                    ? Container(
                                        margin: const EdgeInsets.all(15),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          border:
                                              Border.all(color: Colors.white),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(2, 2),
                                              spreadRadius: 2,
                                              blurRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: (cubit.pickedFiles != null)
                                            ? Image.file(
                                                File(cubit.pickedFiles!.path!))
                                            : null)
                                    : const SizedBox(),
                                cubit.pickedFiles == null
                                    ? const SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cubit.pickedFiles = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColors.redColor,
                                        ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomMaterialButton(
                        function: () {
                          cubit.selectFile();
                        },
                        text: "اختيار صوره الجهاز",
                        borderRadius: AppColors.foreignColor,
                        background: AppColors.foreignColor,
                        radius: 10,
                        textStyle: true,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "اسم الجهاز",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomFormField(
                        type: TextInputType.visiblePassword,
                        isPassword: false,
                        controller: titleController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.requiredField;
                          }
                          return null;
                        },
                        text: "الاسم",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomMaterialButton(
                        function: () {
                          int idDevices;
                          if (formKey.currentState!.validate()) {
                            if (cubit.pickedFiles != null) {
                              if (CacheHelper.getData(key: "number") == null) {
                                idDevices = 0;
                                CacheHelper.saveData(
                                    key: "number", value: idDevices);
                              } else {
                                idDevices =
                                    CacheHelper.getData(key: "number") + 1;
                                CacheHelper.saveData(
                                    key: "number", value: idDevices);
                              }

                              cubit.uploadImage(
                                  idDevices: idDevices,
                                  nameDevice: titleController.text);
                            } else {
                              MyHelpers.showSnackBar(
                                  message: "please enter image",
                                  status: "problem",
                                  context: context);
                            }
                          }
                        },
                        text: "اضافه الجهاز",
                        borderRadius: AppColors.foreignColor,
                        background: AppColors.foreignColor,
                        radius: 10,
                        textStyle: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
