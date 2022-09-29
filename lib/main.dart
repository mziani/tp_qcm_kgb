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
      home: const QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<Question> questionList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("KGB"),
        ),
        body: ListView.builder(
            itemCount: questionList.length,
            itemBuilder: ((context, index) {
              return afficher(content_bis: questionList[index].content, propositions_bis: questionList[index].propositions);
            })));
  }

  @override
  void initState() {
    Question question1 =
        Question(1, "Quel est votre nom ?", "oui", ["tutu", "toto"]);
    Question question2 =
        Question(2, "Quel est votre prenom ?", "Non", ["foo", "bar", "dupont"]);
    Question question3 = Question(3, "Quel est votre origine ?", "oui",
        ["francais", "anglais", "italien"]);

    questionList.add(question1);
    questionList.add(question2);
    questionList.add(question3);

    super.initState();
  }
}

class afficher extends StatefulWidget {
  String content_bis;
  List<String> propositions_bis;
  afficher({required this.content_bis, required this.propositions_bis});

  @override
  State<afficher> createState() => _afficherState();
}

class _afficherState extends State<afficher> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(widget.content_bis),
              trailing: const Icon(Icons.more_vert),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.propositions_bis.length,
                  itemBuilder: (context, i) {
                    return Text(widget.propositions_bis[i]);
                  }),
            )
          ],
        ));
  }
}
