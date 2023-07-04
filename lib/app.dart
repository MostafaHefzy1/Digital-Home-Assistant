import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'authentication/screen/splash_screen.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/util/app_strings.dart';
import 'smart_home/data/repository.dart';
import 'smart_home/data/web_services.dart';
import 'smart_home/presentation/controller/home_cubit.dart';
import 'smart_home/presentation/controller/home_state.dart';
import 'authentication/controller/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider<HomeCubit>(
            create: (BuildContext context) =>
                HomeCubit(HomeRepository(HomeWebServices()))
                  ..fetchAndSaveDataAsList()
                  ..fetchToSmoke()
                  ..getCurrentWeather()
                  ..getNews()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              theme: getThemeDataLight(),
              home: child,
            );
          },
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
