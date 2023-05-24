import 'package:http/http.dart' as http;
import 'package:ips_app/main.dart' as main;
import 'package:flutter/foundation.dart';

String? tokenValue, realtoken;
Future<bool> loginInfo() async {
  final url = Uri.parse('http://54.178.216.208:8080/auth/login');
  String name = main.Home.nameInfo ?? ''; // null이면 빈 문자열로 설정
  String tel = main.Home.phonenumberInfo ?? ''; // null이면 빈 문자열로 설정
  final response = await http.post(
    url,
    body: {
      'name': name,
      'tel': tel,
    },
  );
  tokenValue = response.headers['set-cookie'];
  if (response.statusCode == 200) {
    realtoken = extractTokenFromSetCookieHeader(tokenValue);
    debugPrint("성공이다");
    return true;
  } else {
    debugPrint("실패다");
    return false;
  }
}

String? extractTokenFromSetCookieHeader(var setCookieHeader) {
  // 쿠키 문자열을 쉽게 처리하기 위해 ';'를 기준으로 분리합니다
  List<String> cookies = setCookieHeader.split(';') ?? '';

  // 쿠키 목록에서 'x_auth='로 시작하는 쿠키를 찾습니다
  String? tokenCookie = cookies.firstWhere(
    (cookie) => cookie.trim().startsWith('x_auth='),
    orElse: () => '',
  );

  if (tokenCookie != '') {
    // 'x_auth='를 제외한 토큰 값을 반환합니다
    String? token = tokenCookie.split('=')[1];
    return token;
  }

  return ''; // 토큰이 없는 경우 null을 반환합니다
}
