import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/network/local/sharedpreference.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "fire",
      channelName: "fire",
      channelDescription: "notification for firebase",
      importance: NotificationImportance.High,
      playSound: true,
      channelShowBadge: true,
      enableVibration: true,
      enableLights: true,
    ),
  ]);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}
