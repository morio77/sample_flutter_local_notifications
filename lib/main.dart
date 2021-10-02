import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import './notifications_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // (通知スケジュールに使う)タイムゾーンを設定する
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));

  // flutter_local_notificationsの初期化
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_local_notifications_sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_local_notifications_sample'),
      ),
      body: Center(
        child: Column(
          children: [
            // 今すぐ通知
            TextButton(
              onPressed: () {
                NotificationsUtils.notifyNow();
              },
              child: const Text('今すぐ通知'),
            ),

            // 通知をスケジュール
            TextButton(
              onPressed: () {
                NotificationsUtils.scheduleNotifications(
                  DateTime.now().add(const Duration(seconds: 3)),
                );
              },
              child: const Text('通知をスケジュール'),
            ),

            // スケジュールされた通知をすべてキャンセル
            TextButton(
              onPressed: () {
                NotificationsUtils.cancelNotificationsSchedule();
              },
              child: const Text('スケジュールされた通知をすべてキャンセル'),
            ),
          ],
        ),
      ),
    );
  }
}
