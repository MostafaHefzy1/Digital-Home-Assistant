  // ToDo Custom PickImage

import 'package:flutter/material.dart';

import '../../../core/util/app_color.dart';

// ignore: must_be_immutable
class CustomPickImage extends StatelessWidget {
  CustomPickImage(
      {super.key, required this.getProfileImage, required this.image});

    Function getProfileImage;
  ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          CircleAvatar(
              radius: 65,
              backgroundColor: AppColors.primaryColor,
              child: CircleAvatar(
                backgroundColor: AppColors.greyColor,
                radius: 63.0,
                backgroundImage: image,
              )),
          IconButton(
            alignment: Alignment.bottomLeft,
            // ignore: prefer_const_constructors
            icon: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.camera_alt_sharp,
              ),
            ),
            onPressed: () {
              getProfileImage();
            },
          ),
        ],
      ),
    );
  }
}
