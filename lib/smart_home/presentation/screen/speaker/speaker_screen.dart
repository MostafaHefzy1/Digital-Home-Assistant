import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/util/app_color.dart';
import '../../../../core/util/app_strings.dart';
import '../../controller/home_cubit.dart';

import '../../controller/home_state.dart';

class SpeakerScreen extends StatefulWidget {
  const SpeakerScreen({Key? key}) : super(key: key);

  @override
  State<SpeakerScreen> createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  bool arabicLang = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                AppStrings.canIHelpYou,
                style: Theme.of(context).textTheme.bodyText1,
              )),
              IconButton(
                onPressed: () {
                  cubit.startListening();
                },
                icon: const Icon(Icons.mic),
                iconSize: 30.sp,
                color: AppColors.whiteColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                cubit.word,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 20.sp),
              )
            ],
          ),
        );
      },
    );
  }
}
