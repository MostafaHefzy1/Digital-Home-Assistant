// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../util/app_color.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(10),
        color: Colors.white.withOpacity(0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SpinKitFadingCube(
          color: AppColors.foreignColor,
        ));
  }
}
