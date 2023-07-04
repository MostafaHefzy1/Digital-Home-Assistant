import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/util/app_strings.dart';
import '../../component/devices_component.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: const CustomAppBarTwo(
              title: AppStrings.devices,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 1 / 1.15,
                children: List.generate(
                  HomeCubit.get(context).objectList.length,
                  (index) => DevicesComponent(
                    devicesModel: HomeCubit.get(context).objectList[index],
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
