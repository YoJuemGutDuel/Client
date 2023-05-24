import 'package:flutter/material.dart';
import 'package:ips_app/conversation.dart';
import 'package:ips_app/signup.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:ips_app/loginInfo.dart' as li;
import 'dart:async';
import 'package:ips_app/alarmInfo.dart' as alarm;
import 'package:ips_app/message.dart' as message;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalNotification.init();

  runApp(
    const MaterialApp(
      title: 'Navigator',
      home: IpsApp(),
    ),
  );
}

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
    android:
        AndroidNotificationDetails('alarm 1', '1번 푸시', channelShowBadge: true),
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

    bool result = await alarm.alarmInfo();
    bool result1 = await message.message();
    print('알람이 true인가 false인가요?: $result');
    if (result) {
      await localNotification.zonedSchedule(
        1,
        '희망이',
        '잘 지내시나요? 당신의 하루가 궁금해요.',
        _timeZoneSetting(hour: 4, minute: 16),
        _details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }

    /*await localNotification.zonedSchedule(
      1,
      '희망이',
      '오늘 하루는 어떠셨나요? 저와 대화해보아요.',
      _timeZoneSetting(hour: 8, minute: 00),
      _details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );*/
  }
}

void scheduleFunctionExecution() {
  // 현재 시간 가져오기
  DateTime now = DateTime.now();

  // 설정할 시간 (예: 오늘 오후 11시)
  DateTime scheduledTime = DateTime(now.year, now.month, now.day, 23, 0, 0);

  // 설정한 시간과 현재 시간과의 차이 계산
  Duration difference;
  if (now.isAfter(scheduledTime)) {
    // 이미 지난 시간이면 다음 날로 설정
    DateTime nextDay = scheduledTime.add(const Duration(days: 1));
    difference = nextDay.difference(now);
  } else {
    difference = scheduledTime.difference(now);
  }

  // 차이 시간 이후에 함수 실행
  Timer(difference, scheduleFunctionExecution);
}

class Home extends State<IpsApp> {
  final phonenumber = TextEditingController();
  final name = TextEditingController();
  static String? nameInfo;
  static String? phonenumberInfo;
  static String? nok_phonenumberInfo;
  static bool? phonenumber_authInfo;
  static bool? nok_phonenumber_authInfo;
  FlutterLocalNotification flutterLocalNotification =
      FlutterLocalNotification._();

  @override
  void initState() {
    super.initState();
    FlutterLocalNotification.selectedDatePushAlarm();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("잘못된 정보입니다."),
          actions: <Widget>[
            TextButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: '이름',
                      ),
                      onChanged: (text) {
                        setState(() {
                          nameInfo = text;
                          debugPrint(nameInfo);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: phonenumber,
                      decoration: const InputDecoration(
                        labelText: '전화번호',
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (text) {
                        setState(() {
                          phonenumberInfo = text;
                          debugPrint(phonenumberInfo);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('로그인하기'),
                      onPressed: () {
                        li.loginInfo().then(
                          (result) {
                            if (result) {
                              FlutterLocalNotification.selectedDatePushAlarm();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Conversation()),
                              );
                            } else {
                              _showDialog();
                            }
                          },
                        );

                        /* li.loginInfo().then(
                          (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Conversation()),
                            );
                            /*if (value == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Conversation()),
                              );
                            } else {
                              debugPrint('실패했습니다.');
                            }*/
                          },
                        );*/
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
                              builder: (context) => const SignUp()),
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
