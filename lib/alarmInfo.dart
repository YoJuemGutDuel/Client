import 'package:http/http.dart' as http;
import 'package:ips_app/loginInfo.dart' as login;

Future<bool> alarmInfo() async {
  final tokenValue = login.realtoken;
  final url = Uri.parse('http://54.178.216.208:8080/alarm');
  final response =
      await http.get(url, headers: {'Cookie': 'x_auth=$tokenValue'});

  if (response.statusCode == 200) {
    print(response.body);
    return true;
  } else {
    print(response.body);
    return false;
  }
}
