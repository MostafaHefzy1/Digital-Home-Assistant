import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../../core/network/local/sharedpreference.dart';
import '../../../../core/shared_component/custom_appbar.dart';
import '../../../../core/shared_component/navigate.dart';
import '../bottom_nav_bat.dart';

class ConfrimLocation extends StatelessWidget {
  const ConfrimLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarTwo(
          title: 'تاكيد موقع المنزل',
        ),
        backgroundColor: Colors.transparent,
        body: FlutterLocationPicker(
            mapLanguage: 'ar',
            selectLocationButtonText: 'تاكيد موقع المنزل',
            showZoomController: false,
            showSearchBar: false,
            showSelectLocationButton: true,
            showLocationController: true,
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 50,
            onPicked: (pickedData) {
              CacheHelper.saveData(
                  key: "latitude", value: pickedData.latLong.latitude);
              CacheHelper.saveData(
                  key: "longitude", value: pickedData.latLong.longitude);
              navigatorAndRemove(context, const BottomNavigatorBar());
            }));
  }
}
