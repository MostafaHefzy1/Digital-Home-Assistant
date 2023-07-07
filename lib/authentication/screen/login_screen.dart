import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/shared_component/show_loading_indicator_f.unction.dart';
import '../../core/util/app_color.dart';
import '../../../core/network/local/sharedpreference.dart';
import '../../../core/shared_component/navigate.dart';
import '../../smart_home/presentation/screen/setting/confrim_location.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import '../widget/button_google.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GoogleLoadingState) {
            showLoadingIndicator(context);
          }
          if (state is GoogleSuccessState) {
            Navigator.pop(context);
            CacheHelper.saveData(key: "email", value: state.user.user!.email);
            CacheHelper.saveData(
                key: "token", value: state.user.credential!.token);
            CacheHelper.saveData(
                key: "nameUser", value: state.user.user!.displayName);
            CacheHelper.saveData(
                key: "imageUser", value: state.user.user!.photoURL);
            navigatorAndRemove(context, const ConfrimLocation());
          }
          if (state is GoogleFailedState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Center(child: ButtonGoogle()),
            ),
          );
        },
      ),
    );
  }
}
