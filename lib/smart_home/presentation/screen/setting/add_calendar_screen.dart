import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/custom_form_field.dart';
import '../../../../core/shared_component/custom_material_button.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_strings.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class AddCalendar extends StatefulWidget {
  AddCalendar({super.key});

  @override
  State<AddCalendar> createState() => _AddCalendarState();
}

class _AddCalendarState extends State<AddCalendar> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  DateTime Date = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homecubit = HomeCubit.get(context);
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBarTwo(title: "اضافه حدث"),
              body: Column(
                children: [
/*
             
*/
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.whiteColor, width: 1.5),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomFormField(
                      type: TextInputType.text,
                      controller: _titleController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.requiredField;
                        }
                        return null;
                      },
                      text: "العنوان",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.whiteColor, width: 1.5),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomFormField(
                      type: TextInputType.visiblePassword,
                      isPassword: false,
                      controller: _descriptionController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.requiredField;
                        }
                        return null;
                      },
                      text: "التفاصيل",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Date,
                              firstDate: Date,
                              lastDate: DateTime(2040))
                          .then((value) {
                        setState(() {
                          startDate = value!;
                        });
                      });
                    },
                    child: Container(
                      height: 40.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.greyColor, width: 1.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text("تاريخ البدايه",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 11.sp)),
                          const Spacer(),
                          const Icon(FontAwesomeIcons.calendarDays,
                              color: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: Date,
                              firstDate: Date,
                              lastDate: DateTime(2040))
                          .then((value) {
                        setState(() {
                          endDate = value!;
                        });
                      });
                    },
                    child: Container(
                      height: 40.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.greyColor, width: 1.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text("تاريخ النهايه",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 11.sp)),
                          const Spacer(),
                          const Icon(FontAwesomeIcons.calendarDays,
                              color: AppColors.whiteColor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomMaterialButton(
                    function: () {
                      Add2Calendar.addEvent2Cal(homecubit.buildEvent(
                          startDate: startDate,
                          endDate: endDate,
                          title: _titleController.text,
                          description: _descriptionController.text));
                    },
                    text: "اضافه الي التقويم",
                    borderRadius: AppColors.foreignColor,
                    background: AppColors.foreignColor,
                    radius: 10,
                    textStyle: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
