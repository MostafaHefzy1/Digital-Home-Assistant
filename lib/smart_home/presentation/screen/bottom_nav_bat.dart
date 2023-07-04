import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/app_color.dart';
import '../../../core/util/app_strings.dart';
import '../controller/home_cubit.dart';
import '../controller/home_state.dart';

class BottomNavigatorBar extends StatelessWidget {
  const BottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.navigateToNextScreen(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: AppStrings.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mic,
                  ),
                  label: AppStrings.speaker,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                  ),
                  label: AppStrings.chat,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: AppStrings.setting,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
