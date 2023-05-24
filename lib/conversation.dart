import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:ips_app/loginInfo.dart' as login;
import 'dart:convert';

class Conversation extends StatefulWidget {
  Conversation({super.key}) {
    tts.setLanguage('kor');
    tts.setSpeechRate(0.5);
  }
  final FlutterTts tts = FlutterTts();

  @override
  ConversationUI createState() => ConversationUI();
}

class ConversationUI extends State<Conversation> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '버튼을 눌러 희망이와의 대화를 시작해보세요!';
  final TextEditingController controller = TextEditingController();

  String? tokenValue = login.realtoken;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('희망이와의 대화'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: speech_text,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> speech_text() async {
    await _listen().then((value) async {
      if (value != null) {
        String? response = await chatInfo(value);
        if (response != null) {
          setState(() {
            _text = response;
          });
          controller.text = _text;
          widget.tts.speak(controller.text);
        }
      }
    });
  }

  Future<String?> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      widget.tts.stop();
      return _text;
    }
    return null;
  }

  Future<String?> chatInfo(String chat) async {
    final url = Uri.parse('http://54.178.216.208:8080/chat');
    debugPrint('처음 chatInfo : $chat');
    final response = await http.post(
      url,
      body: {
        'input': chat,
      },
      headers: {'Cookie': 'x_auth = $tokenValue'},
    );

    debugPrint('chatInfo : $chat');
    if (response.statusCode == 200) {
      debugPrint('인식 성공');
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];
      return data;
    } else {
      debugPrint('인식 실패');
      debugPrint(response.body);
      return null;
    }
  }
}
