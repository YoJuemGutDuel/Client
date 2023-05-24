import "package:flutter/material.dart";
import 'package:ips_app/smsInfo.dart' as smsinfo;
import 'package:ips_app/checkInfo.dart' as checkinfo;
import 'package:ips_app/nok_smsInfo.dart' as nok_smsinfo;
import 'package:ips_app/nok_checkInfo.dart' as nok_checkinfo;
import 'package:ips_app/signupInfo.dart' as signupinfo;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpUI();
  }
}

class SignUpUI extends State<SignUp> {
  final phonenumber = TextEditingController();
  final nok_phonenumber = TextEditingController();
  final name = TextEditingController();
  final check = TextEditingController();
  final nok_check = TextEditingController();
  static String? nameInfo;
  static String? phonenumberInfo;
  static String? nok_phonenumberInfo;
  static String? codeInfo, nok_codeInfo;
  static bool? realcheck = false, realNokcheck = false;
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("인증번호가 전송되었습니다."),
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

  void checkDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("인증이 완료되었습니다."),
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

  void loginsuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("회원가입이 완료되었습니다."),
          actions: <Widget>[
            TextButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
                //Navigator.pushNamed(context, '/home');
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => main.Home(),
                  ),
                );*/
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  '회원 가입',
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
                    labelText: '본인 성함',
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
                    labelText: '본인 전화번호',
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
                  child: const Text('인증 번호 요청'),
                  onPressed: () {
                    smsinfo.smsInfo().then((value) {
                      _showDialog();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: check,
                  decoration: const InputDecoration(
                    labelText: '인증 번호',
                  ),
                  onChanged: (text) {
                    setState(() {
                      codeInfo = text;
                      debugPrint('인증코드 : $codeInfo');
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('확인'),
                  onPressed: () {
                    checkinfo.checkInfo().then((value) {
                      print('본인 인증번호 확인 값: $value');
                      if (value == true) {
                        realcheck = true;
                        print('realcheck는 true입니다.');
                        checkDialog();
                      } else {
                        debugPrint('실패했습니다.');
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: nok_phonenumber,
                  decoration: const InputDecoration(
                    labelText: '보호자 전화번호',
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (nokText) {
                    setState(() {
                      nok_phonenumberInfo = nokText;
                      debugPrint(nok_phonenumberInfo);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('인증 번호 요청'),
                  onPressed: () {
                    nok_smsinfo.nok_smsInfo().then((value) {
                      if (value) {
                        _showDialog();
                      } else {
                        debugPrint("보호자 번호 인증 번호 요청 실패");
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: nok_check,
                  decoration: const InputDecoration(
                    labelText: '인증 번호',
                  ),
                  onChanged: (text) {
                    setState(() {
                      nok_codeInfo = text;
                      debugPrint('인증코드 : $nok_codeInfo');
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('확인'),
                  onPressed: () {
                    nok_checkinfo.nok_checkInfo().then((nokValue) {
                      print('보호자 인증번호 확인값: $nokValue');
                      if (nokValue == true) {
                        realNokcheck = true;
                        print('realNokcheck는 true입니다.');
                        checkDialog();
                      } else {
                        debugPrint('실패했습니다.');
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('회원가입하기'),
                  onPressed: () {
                    signupinfo.signupInfo().then((value) {
                      if (realcheck == true && realNokcheck == true) {
                        loginsuccessDialog();
                      } else {
                        debugPrint('회원가입 실패');
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
