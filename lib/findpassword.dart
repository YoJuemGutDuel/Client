import "package:flutter/material.dart";

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return FindPasswordUI();
  }
}

class FindPasswordUI extends State<FindPassword> {
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
                  '비밀번호 찾기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '본인 성함',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '본인 전화번호',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '보호자 성함',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '보호자 전화번호',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('확인'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
