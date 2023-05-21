import 'package:flutter/material.dart';
import 'package:ips_app/findpassword.dart';
import 'package:ips_app/login.dart';
import 'package:ips_app/signup.dart';
import 'package:ips_app/Conversation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void main() => runApp(
      const MaterialApp(
        title: 'Navigator',
        home: IpsApp(),
      ),
    );

class IpsApp extends StatefulWidget {
  const IpsApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static const NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails('alarm 1', '1번 푸시'),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static tz.TZDateTime _timeZoneSetting({
    required int hour,
    required int minute,
  }) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    return scheduledDate;
  }

  static Future<void> selectedDatePushAlarm() async {
    FlutterLocalNotificationsPlugin localNotification =
        FlutterLocalNotificationsPlugin();

    await localNotification.zonedSchedule(
      1,
      '갹',
      '성공이다...',
      _timeZoneSetting(hour: 19, minute: 40),
      _details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    await flutterLocalNotificationsPlugin.show(
        0, 'test title', 'test body', notificationDetails);
  }
}

class Home extends State<IpsApp> {
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FlutterLocalNotification.selectedDatePushAlarm();
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: phonenumber,
                      decoration: const InputDecoration(
                        labelText: '전화번호',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        debugPrint("First Text Field: $text");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                      ),
                      obscureText: true,
                      onChanged: (text) {
                        debugPrint("Second Text Field: $text");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('로그인하기'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('회원가입하기'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingUp()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('비밀번호찾기'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FindPassword()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('메인 화면'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpeechScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
