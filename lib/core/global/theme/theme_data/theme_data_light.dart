import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/app_color.dart';
import '../../app_color/app_color_light.dart';
import '../../app_fontweight/app_fontweight.dart';
import '../../app_size/app_elevation_theme.dart';
import '../../app_size/app_size_theme.dart';


ThemeData getThemeDataLight() => ThemeData(
  useMaterial3: true,
      primaryColor: AppColorsLight.primaryColor,
      scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
      appBarTheme: _getAppBarTheme(),
      bottomNavigationBarTheme: _getBottomNavigatorBarTheme(),
      floatingActionButtonTheme: _getFloatingActionButtonTheme(),
      textTheme: _getTextTheme(),
      inputDecorationTheme: _getInputDecorationTheme(),
      textSelectionTheme: _getTextSelectionTheme(),
      textButtonTheme: _getTextButtonTheme(),
      switchTheme: _getSwitchTheme(),
    );

AppBarTheme _getAppBarTheme() => AppBarTheme(
      backgroundColor: AppColorsLight.appBarBackgroundColor,
      elevation: AppElevationTheme.elevationAppBarLight,
      titleSpacing: AppSizeTheme.titleSpacingAppBarSize,

      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: AppColorsLight.statusBarColor,
        statusBarIconBrightness: Brightness.light,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColorsLight.actionsIconColor,
        size: AppSizeTheme.actionsIconSize,
      ),
      centerTitle: true,
      toolbarHeight: AppSizeTheme.toolbarHeightSize,
      titleTextStyle: TextStyle(
        color: AppColorsLight.titleTextAppBarColor,
        fontSize: AppSizeTheme.titleTextAppBarFontSize,
        fontWeight: AppFontWeightTheme.titleTextAppBarFontWeight,
      ),
      iconTheme: IconThemeData(
        color: AppColorsLight.iconAppBarColor,
        size: AppSizeTheme.iconAppBarSize,
      ),
    );

BottomNavigationBarThemeData _getBottomNavigatorBarTheme() =>
     BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColorsLight.selectedItemBottomNavigationBarColor,
      unselectedItemColor:
          AppColorsLight.unSelectedItemBottomNavigationBarColor,
      elevation: AppElevationTheme.elevationBottomNavigationBar,
      backgroundColor: AppColorsLight.backgroundBottomNavigationBarColor,
    );

FloatingActionButtonThemeData _getFloatingActionButtonTheme() =>
    FloatingActionButtonThemeData(
      backgroundColor: AppColors.foreignColor,
      iconSize: AppSizeTheme.iconFloatingActionButtonSize,
    );

TextTheme _getTextTheme() => TextTheme(
      bodyText1: TextStyle(
        fontSize: AppSizeTheme.bodyText1FontSize,
        fontWeight: AppFontWeightTheme.bodyText1FontWeight,
        color: AppColorsLight.bodyText1Color,
      ),
      bodyText2: TextStyle(
        fontSize: AppSizeTheme.bodyText2FontSize,
        color: AppColorsLight.bodyText2Color,
      ),
      subtitle1: TextStyle(
        fontSize: AppSizeTheme.subtitle1FontSize,
        fontWeight: AppFontWeightTheme.subText1FontWeight,
        color: AppColorsLight.subText1Color,
        height: AppSizeTheme.heightSubTitle1,
      ),
      subtitle2: TextStyle(
        fontSize: AppSizeTheme.subtitle2FontSize,
        color: AppColorsLight.subText2Color,
      ),
    );

InputDecorationTheme _getInputDecorationTheme() => InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: AppSizeTheme.labelInputDecorationFontSize,
        color: AppColors.blackColor,
        backgroundColor: AppColors.primaryColor,
      ),
      errorStyle: TextStyle(
        fontSize: AppSizeTheme.errorInputDecorationFontSize,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: AppColorsLight.focusedBorderInputDecorationColor,
        ),
        borderRadius: BorderRadius.circular(
          AppSizeTheme.borderInputDecorationSize,
        ),
      ),
      border: OutlineInputBorder(
        borderSide:  BorderSide(
          color: AppColorsLight.borderInputDecorationColor,
        ),
        borderRadius: BorderRadius.circular(
          AppSizeTheme.borderInputDecorationSize,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: AppColorsLight.enabledBorderInputDecorationColor,
        ),
        borderRadius: BorderRadius.circular(
          AppSizeTheme.borderInputDecorationSize,
        ),
      ),
  prefixIconColor: AppColors.blackColor,
  suffixIconColor: AppColors.blackColor,

);

TextSelectionThemeData _getTextSelectionTheme() => const TextSelectionThemeData(
      cursorColor: AppColorsLight.cursorTextSelectionColor,
      selectionHandleColor: AppColorsLight.selectionHandleTextSelectionColor,
    );

TextButtonThemeData _getTextButtonTheme() => TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsLight.textButtonColor,

        textStyle: TextStyle(
          fontSize: AppSizeTheme.textButtonFontSize,
          color: AppColors.greyColor,

        ),
      ),
    );

SwitchThemeData _getSwitchTheme() => SwitchThemeData(
      splashRadius: AppSizeTheme.splashRadiusSwitchSize,
      thumbColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColorsLight.thumbSelectedSwitchColor;
        }
        if (states.contains(MaterialState.disabled)) {
          return AppColorsLight.thumbDisabledSwitchColor;
        }
        return AppColorsLight.thumbUnSelectedSwitchColor;
      }),

      trackColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColorsLight.trackSelectedSwitchColor;
        }
        if (states.contains(MaterialState.disabled)) {
          return AppColorsLight.trackDisabledSwitchColor;
        }
        return AppColorsLight.trackUnSelectedSwitchColor;
      }),
    );


