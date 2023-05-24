import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ips_app/signup.dart' as su;
import 'dart:convert';

Future<bool> signupInfo() async {
  final url = Uri.parse('http://54.178.216.208:8080/auth/signup');
  String name = su.SignUpUI.nameInfo ?? ''; // null이면 빈 문자열로 설정
  String tel = su.SignUpUI.phonenumberInfo ?? ''; // null이면 빈 문자열로 설정
  String nokTel = su.SignUpUI.nok_phonenumberInfo ?? '';
  bool? telAuth = su.SignUpUI.realcheck;
  bool? nokTelAuth = su.SignUpUI.realNokcheck;
  print('이름: $name , 전화번호 : $tel, 보호자 전화번호 : $nokTel');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'tel': tel,
      'nok_tel': nokTel,
      'tel_auth': telAuth,
      'nok_tel_auth': nokTelAuth,
    }),
  );
  if (response.statusCode == 200) {
    debugPrint('성공');
    return true;
  } else {
    print(response.body);
    print('string으로 바꾼 $tel');
    print('string으로 바꾼 telAuth: $telAuth');
    print('string으로 바꾼 nokTelAuth: $nokTelAuth');
    return false;
  }
}
