// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zeze_mobile/smart_home/presentation/controller/home_state.dart';
import 'package:zeze_mobile/smart_home/presentation/screen/chat/chat_screen.dart';
import 'package:zeze_mobile/smart_home/presentation/screen/home/home_screen.dart';
import 'package:zeze_mobile/smart_home/presentation/screen/setting/setting_screen.dart';
import 'package:zeze_mobile/smart_home/presentation/screen/speaker/speaker_screen.dart';
import '../../../core/models/devices_model.dart';
import '../../../core/models/news_model.dart';
import '../../../core/models/smoke_model.dart';
import '../../../core/models/weather_model.dart';
import '../../../core/network/local/sharedpreference.dart';
import '../../../core/network/provider/chat_gpt_provider.dart';
import '../../../core/notfication/local_notification_for_remembe_training.dart';
import '../../../core/util/app_strings.dart';
import '../../data/repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(
    this.homeRepository,
  ) : super(HomeInitial());

  int currentIndex = 0;
  /* --------------------------------------------------------------------------- */
  // ToDo Text To Speech
  final FlutterTts flutterTts = FlutterTts();
  String word = "";
  PlatformFile? pickedFiles;
  List<Widget> screens = [
    const HomeScreen(),
    SpeakerScreen(),
    const ChatScreen(),
    const SettingScreen(),
  ];

  SpeechToText speechToText = SpeechToText();
  UploadTask? uploadTask;

  static HomeCubit get(context) => BlocProvider.of(context);

  void navigateToNextScreen(int index) {
    currentIndex = index;
    emit(NavigateToNextScreenSuccessState());
  }

  void startListening() async {
    word = "";
    await speechToText.initialize();
    await speechToText.listen(onResult: onSpeechResult, localeId: "ar");
    emit(StartListenSuccessState());
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    word = result.recognizedWords;
    List<String> words = word.split(' ');
    if (words.length > 1) {
      detectedWord();
    }
    emit(GetTextSuccess());
  }

  //ToDo Function Speak
  Future speak({required String text}) async {
    await flutterTts.setLanguage("ar-eg");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    emit(TextToSpeechSuccessState());
  }

  Event buildEvent({
    required DateTime startDate,
    required DateTime endDate,
    required String title,
    required String description,
  }) {
    return Event(
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      allDay: false,
      iosParams: IOSParams(
        reminder: const Duration(minutes: 40),
        url: CacheHelper.getData(key: "email"),
      ),
      androidParams: AndroidParams(
        emailInvites: ["${CacheHelper.getData(key: "email")}"],
      ),
    );
  }

  void sendEmailLauncher({
    required String emailSender,
    required String subjectEmail,
    required String bodyEmail,
  }) async {
    // String email = Uri.encodeComponent("${CacheHelper.getData(key: "email")}");
    String email = Uri.encodeComponent(emailSender);
    String subject = Uri.encodeComponent(subjectEmail);
    String body = Uri.encodeComponent(bodyEmail);
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    pickedFiles = result.files.first;
    emit(ImagePickedSuccessState());
  }

  void uploadImage({required String nameDevice, required int idDevices}) async {
    final path = 'files/${pickedFiles!.name}';
    final file = File(pickedFiles!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapShot = await uploadTask!.whenComplete(() {});
    await snapShot.ref.getDownloadURL().then((value) async {
      emit(CreateProductLoadingState());
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child("devices");
      databaseReference
        ..child('device $idDevices').set({
          "nameDevice": nameDevice,
          "imageDevice": value,
          "isOpened": false,
          "id": 'device $idDevices'
        });

      log("value $value");
      emit(CreateProductSuccessState());
    });
  }

  final databaseReference = FirebaseDatabase.instance.ref().child("devices");
  List<AllDevicesModel> objectList = [];
  void fetchAndSaveDataAsList() {
    databaseReference.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      log(event.snapshot.toString());
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      if (values != null) {
        objectList = values.values.map((item) {
          return AllDevicesModel.fromMap(item);
        }).toList();
      }
    });
  }

  IsSomkeModel? isSomkeModel;
  void fetchToSmoke() {
    FirebaseDatabase.instance.ref().onValue.listen((event) async {
      DataSnapshot snapshot = event.snapshot;
      log(snapshot.value.toString());

      Map<dynamic, dynamic>? values = snapshot.value as Map?;

      if (values != null) {
        isSomkeModel = IsSomkeModel.fromMap(values);
      }

      if (isSomkeModel!.isSmoke) {
        await LocalNotificationForRememberTraining.init(
            title: AppStrings.titleNotification,
            body: AppStrings.bodyNotification);
        await launchUrlString("tel:191");
        await speak(text: "سوف يتم الاتصال  برقم المطافي");
      }

      emit(SomeAndTempSuccessState());
    });
  }

  // ToDo Function Get Weather
  WeatherModel? weatherModel;
  void getCurrentWeather() {
    homeRepository.getCurrentWeather().then((value) {
      weatherModel = value;
      emit(GetCurrentWeatherSuccess());
    }).catchError((error) {
      emit(GetCurrentWeatherFailed());
    });
  }

  // ToDo Function Get News
  NewsModel? newsModel;
  void getNews() {
    homeRepository.getNews().then((value) {
      newsModel = value;
      emit(GetNewsSuccess());
    }).catchError((error) {
      emit(GetNewsFailed());
    });
  }

  void detectedWord() async {
    if (word.contains("الطقس") ||
        word.contains("المناخ") ||
        word.contains("الجو")) {
      speak(text: (weatherModel!.weather![0].description!));
    } else if (word.contains("تاريخ")) {
      speak(text: DateTime.now().toString().substring(0, 10));
    } else if (word.contains("اخبار") || word.contains("نشره")) {
      speak(
          text: newsModel!.articles![0].description ??
              newsModel!.articles![0].title!);
    } else if (word.contains("وقت") || word.contains("ساعه")) {
      speak(text: "${DateTime.now().hour} و ${DateTime.now().minute} دقيقة}");
    } else if (word.contains("اقفل") || word.contains("افتح")) {
      if (word.contains("اقفل")) {
        int wordIndex = word.indexOf("اقفل");
        String spaceIndex =
            word.toString().substring(wordIndex).split("اقفل ").last;
        log(spaceIndex);
        openOrCloseDevice(text: "اقفل", nameDevice: spaceIndex);
      } else {
        int wordIndex = word.indexOf("افتح");
        String spaceIndex =
            word.toString().substring(wordIndex).split("افتح ").last;
        log(spaceIndex);
        openOrCloseDevice(text: "افتح", nameDevice: spaceIndex);
      }
    } else if (word.contains("كول") ||
        word.contains("اتصل") ||
        word.contains("كلم") ||
        word.contains("رساله")) {
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      await searchWithContent(text: word);

      speak(text: "برجاء الانتظار قليلا");
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    }
  }

  Future<void> searchWithContent({required String text}) async {
    if (checkIFUserDontWantToUseChatGPT(text)) {
      var isContactAccessible = await Permission.contacts.status;
      if (!isContactAccessible.isGranted) {
        await Permission.contacts.request();
      }
      isContactAccessible = await Permission.contacts.status;
      if (isContactAccessible.isDenied) {
        return;
      }
      var contacts = await ContactsService.getContacts();
      var contact = contacts.firstWhere(
        (element) {
          if (element.displayName == null) {
            return false;
          }
          return text.contains(element.displayName!.toLowerCase());
        },
        orElse: () => Contact(displayName: '', phones: []),
      );

      if (contact.phones!.isEmpty) {
        return;
      }

      if (checkIFUserWantToCall(text)) {
        launchUrlString("tel://${contact.phones?.first.value}");
      }
      if (checkIFUserWantToSendSMS(text)) {
        launchUrlString("sms://${contact.phones?.first.value}");
      }
      if (checkIFUserWantToSendWhatsApp(text)) {
        launchUrlString("whatsapp://send?phone=${contact.phones?.first.value}");
      }
    }
  }

  openOrCloseDevice({required String text, required String nameDevice}) {
    for (int i = 0; i < objectList.length; i++) {
      if (objectList[i].title == nameDevice) {
        if (text == "اقفل") {
          objectList[i].isOpened = false;
          FirebaseDatabase.instance
              .ref()
              .child('devices/${objectList[i].id}/isOpened')
              .set(false);
        } else {
          objectList[i].isOpened = true;
          FirebaseDatabase.instance
              .ref()
              .child('devices/${objectList[i].id}/isOpened')
              .set(true);
        }
      }
    }
  }
}
