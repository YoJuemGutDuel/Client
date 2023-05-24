import 'package:http/http.dart' as http;
import 'package:ips_app/loginInfo.dart' as login;

Future<bool> message() async {
  final tokenValue = login.realtoken;
  final url = Uri.parse('http://54.178.216.208:8080/message');
  print('토큰 밸류 : $tokenValue');
  final response =
      await http.get(url, headers: {'Cookie': 'x_auth=$tokenValue'});

  print('서버로부터 받아온 메시지 정보 : ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    return true;
  } else {
    print(response.body);
    return false;
  }
}
