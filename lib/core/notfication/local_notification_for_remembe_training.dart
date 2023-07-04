import 'package:awesome_notifications/awesome_notifications.dart';
import '../util/app_images.dart';
class LocalNotificationForRememberTraining {
  static init({required String title, required String body}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'fire',
        title: title,
        body: body,
        bigPicture: 'asset://${AppImages.splashScreenImage}',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
