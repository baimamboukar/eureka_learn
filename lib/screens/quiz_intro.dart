import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screen_lock/heading_title.dart';

class QuizIntro extends HookWidget {
  const QuizIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadingTitle(text: "Quizz intro"),
            Text(
                "Please give some information about the quizz you want to take"),
                
          ],
        ),
      ),
    );
  }
}
