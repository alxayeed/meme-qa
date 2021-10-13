import 'package:flutter/material.dart';
import 'package:meme_qa/screens/homepage.dart';

void main() {
  runApp(const MemeQa());
}

class MemeQa extends StatelessWidget {
  const MemeQa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meme QA",
      // ignore: todo
      //TODO: change theme color
      // theme: ThemeData(
      //   primarySwatch: Colors.cyan
      // ),
      home: Homepage(),
    );
  }
}
