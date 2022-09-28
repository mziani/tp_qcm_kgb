import 'package:flutter/material.dart';
import 'models/question.dart';

void main() {
  runApp(const KGBapp());
}

class KGBapp extends StatelessWidget {
  const KGBapp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QCM KGB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}
