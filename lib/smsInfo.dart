import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ips_app/signup.dart' as su;

Future<bool> smsInfo() async {
  final url = Uri.parse('http://54.178.216.208:8080/auth/sms');
  String tel = su.SignUpUI.phonenumberInfo ?? ''; // null이면 빈 문자열로 설정

  final response = await http.post(
    url,
    body: {
      'tel': tel,
    },
  );
  if (response.statusCode == 200) {
    debugPrint('인증 메시지 전송 성공');
    return true;
  } else {
    return false;
  }
}
