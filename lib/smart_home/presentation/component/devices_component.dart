// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeze_mobile/core/shared_component/custom_switch.dart';
import 'package:zeze_mobile/core/util/app_color.dart';
import 'package:zeze_mobile/smart_home/presentation/controller/home_cubit.dart';

import '../../../core/models/devices_model.dart';
import '../controller/home_state.dart';

class DevicesComponent extends StatefulWidget {
  final AllDevicesModel devicesModel;

  const DevicesComponent({
    Key? key,
    required this.devicesModel,
  }) : super(key: key);

  @override
  State<DevicesComponent> createState() => _DevicesComponentState();
}

class _DevicesComponentState extends State<DevicesComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  widget.devicesModel.image,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget.devicesModel.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              widget.devicesModel.title == "غرفه النوم"
                  ? Text(
                      " ° ${cubit.isSomkeModel!.bedroomTemp.toString()}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 22, color: AppColors.foreignColor),
                    )
                  : SizedBox(),
              CustomSwitch(
                activeColor: AppColors.foreignColor,
                inactiveThumbColor: AppColors.lightGrey400Color,
                function: () {
                  setState(() {
                    widget.devicesModel.isOpened =
                        !widget.devicesModel.isOpened;
                    FirebaseDatabase.instance
                        .ref()
                        .child('devices/${widget.devicesModel.id}/isOpened')
                        .set(widget.devicesModel.isOpened);
                  });
                },
                isVisible: widget.devicesModel.isOpened,
              ),
            ],
          ),
        );
      },
    );
  }
}
