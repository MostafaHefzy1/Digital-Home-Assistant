
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/app_color.dart';
import '../../../core/util/app_images.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';

class ButtonGoogle extends StatelessWidget {
  const ButtonGoogle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.whiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: AppColors.primaryColor)))),
            onPressed: () {
              AuthCubit.get(context).googleSignIn();
            },
            child: Row(children: [
              Text("Google Sigin",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.primaryColor)),
              const Spacer(),
              Image.asset(
                AppImages.googleImage,
                fit: BoxFit.cover,
                height: 30.h,
                width: 30.w,
              )
            ]));
      },
    );
  }
}
