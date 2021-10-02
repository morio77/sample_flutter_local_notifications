import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsUtils {
  // 今すぐ通知
  static Future<void> notifyNow() async {
    final flnp = FlutterLocalNotificationsPlugin();
    flnp.show(
      0,
      'タイトル',
      '本文',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          '手動通知',
          'あなたがボタンをタップしたときに通知されます',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(
          presentSound: true,
        ),
      ),
    );
  }

  // 通知をスケジュール
  static Future<void> scheduleNotifications() async {}

  // 通知をキャンセル
  static Future<void> cancelNotificationsSchedule() async {}
}
