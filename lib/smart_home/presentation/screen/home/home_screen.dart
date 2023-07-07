import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/network/local/sharedpreference.dart';
import '../../../../core/shared_component/LoadingIndicator.dart';

import '../../../../core/shared_component/custom_text_button.dart';
import '../../../../core/shared_component/navigate.dart';
import '../../../../core/shared_component/show_loading_indicator_f.unction.dart';
import '../../../../core/util/app_color.dart';

import '../../../../core/util/app_strings.dart';
import '../../component/devices_component.dart';
import '../../component/name_and_image_component.dart';
import '../../controller/home_cubit.dart';
import '../setting/devices_screen.dart';
import '../../controller/home_state.dart';
import 'add_devices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final auth  = FirebaseAuth.instance ;
  // final ref = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SwitchButtonSuccessState ||
            state is CreateProductSuccessState) {
          HomeCubit.get(context).fetchAndSaveDataAsList();
        }
        if (state is GetAllDataInFireBaseLoadingState) {
          showLoadingIndicator(context);
        }
        if (state is GetAllDataInFireBaseSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.newsModel != null &&
                cubit.weatherModel != null &&
                cubit.isSomkeModel != null
            ? SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CustomTextButton(
                              function: () {
                                print(CacheHelper.getData(key: "latitude"));
                                print(CacheHelper.getData(key: "longitude"));
                              },
                              text: "text"),
                          const NameAndImageComponent(),
                          SizedBox(
                            height: 100.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navigatorTo(context, AddDevicesScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.darkGreyColor,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        AppStrings.addDevices,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: AppColors.greyColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CustomTextButton(
                                  function: () {
                                    navigatorTo(context, const DevicesScreen());
                                  },
                                  text: AppStrings.viewAll),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 15.0,
                            childAspectRatio: 1 / 1.15,
                            children: List.generate(
                              cubit.objectList.length > 4
                                  ? 4
                                  : cubit.objectList.length,
                              (index) => DevicesComponent(
                                devicesModel: cubit.objectList[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(child: LoadingIndicator());
      },
    );
  }
}
