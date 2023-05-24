import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ips_app/signup.dart' as su;

Future<bool> checkInfo() async {
  final url = Uri.parse('http://54.178.216.208:8080/auth/sms/check');
  String tel = su.SignUpUI.phonenumberInfo ?? ''; // null이면 빈 문자열로 설정
  String code = su.SignUpUI.codeInfo ?? '';

  final response = await http.post(
    url,
    body: {'tel': tel, 'code': code},
  );
  print(response.body);
  if (response.statusCode == 200) {
    debugPrint('인증 번호 확인 성공');
    return true;
  } else {
    debugPrint('인증 번호 확인 실패');
    return false;
  }
}
