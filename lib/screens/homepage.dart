// ignore_for_file: avoid_print, unused_field, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:meme_qa/models/answer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  /// text editing controller to control tesxxt fileds
  final TextEditingController _questionFieldController =
      TextEditingController();

  // Store current answer object
  Answer? _currentAnswer;

  // process answer response
  _handleGetAnswer() async {
    String questionText = _questionFieldController.text.trim();
    bool invalidQuestion = questionText != null &&
        questionText.isNotEmpty &&
        questionText[questionText.length - 1] == "?";
    if (!invalidQuestion) {
      return;
    }
    String url = 'https://yesno.wtf/api';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 && response.body != null) {
        Answer answer = Answer.fromJson(response.body);

        setState(() {
          _currentAnswer = answer;
        });
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: todo
        //TODO: center allign
        title: const Text('Meme QA'),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_currentAnswer != null)
            Stack(
              children: [
                Container(
                  height: 250,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_currentAnswer!.image))),
                ),
                Positioned.fill(
                    bottom: 20,
                    right: 20,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(_currentAnswer!.answer.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))))
              ],
            ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: TextField(
              controller: _questionFieldController,
              decoration: const InputDecoration(
                labelText: "Ask what's on your mind",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _handleGetAnswer,
                child: const Text("Ask Me"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Refresh"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
