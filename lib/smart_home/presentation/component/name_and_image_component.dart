import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeze_mobile/core/util/app_color.dart';
import '../../../core/network/local/sharedpreference.dart';
import '../../../core/shared_component/custom_networkimage.dart';
import '../../../core/util/app_images.dart';
import '../../../core/util/app_strings.dart';
import '../controller/home_cubit.dart';
import '../controller/home_state.dart';

class NameAndImageComponent extends StatelessWidget {
  const NameAndImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit   =HomeCubit.get(context); 
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${AppStrings.welcome} ${CacheHelper.getData(key: "nameUser")}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16),
                  ),
                    Text(
                    "درجه حرارة المنزل",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16 ,),
                  ),
                  Text(
                    " ° ${cubit.isSomkeModel!.livingRoomTemp.toString()}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16,color: AppColors.foreignColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                child: CustomNetworkImage(
              image: AppImages.profileImage,
            )),
          ],
        );
      },
    );
  }
}
