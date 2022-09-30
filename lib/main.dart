import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/question.dart';
import 'dart:developer' as developer;

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
        primarySwatch: Colors.teal,
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
              return afficher(
                  content_bis: questionList[index].content,
                  propositions_bis: questionList[index].propositions,
                  rightAnswer_bis: questionList[index].rightAnswer);
            })));
  }

  @override
  void initState() {
    Question question1 = Question(
        1,
        "Dans quel pays peut-on trouver la Catalogne, l’Andalousie et la Castille ?",
        "Espagne",
        ["Espagne", "Italie", "France"]);
    Question question2 = Question(
        2,
        "Quel pays a remporté la coupe du monde de football en 2014 ?",
        "Allemagne",
        ["Allemagne", "Brézil", "Argentine"]);
    Question question3 = Question(
        3,
        "Quel est l’accent du deuxième e sur le mot FENETRE ?",
        "L'accent circonflexe",
        ["L'accent aigu", "L'accent grave", "L'accent circonflexe"]);
    Question question4 = Question(
        4,
        "Quel célèbre dictateur dirigea l’URSS du milieu des années 1920 à 1953 ?",
        "Staline",
        ["Molotov", "Lénine", "Staline"]);
    Question questionSansPropo = Question(
        5,
        "Le Goulag, en tant que système pénitentiaire centralisé, est créé en... ?",
        "1922", []);
    Question questionSansPropo2 = Question(
        6,
        "Combien de détenus comptait le Goulag à son apogée, en 1951 ?",
        "2, 5 millions", []);

    questionList.add(question1);
    questionList.add(questionSansPropo);
    questionList.add(question2);
    questionList.add(questionSansPropo2);
    questionList.add(question3);
    questionList.add(question4);

    super.initState();
  }
}

class afficher extends StatefulWidget {
  String content_bis;
  String rightAnswer_bis;

  List<String> propositions_bis;
  afficher(
      {super.key,
      required this.content_bis,
      required this.propositions_bis,
      required this.rightAnswer_bis});

  @override
  State<afficher> createState() => _afficherState();
}

class _afficherState extends State<afficher> {
  bool _isShow = true;
  final _formKey = GlobalKey<FormState>();
  String reponse = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.question_answer_sharp),
              title: Text(widget.content_bis),
              trailing: IconButton(
                  onPressed: () {
                    if (_isShow == false) {
                      setState(() {
                        _isShow = true;
                      });
                    } else {
                      setState(() {
                        _isShow = false;
                      });
                    }
                  },
                  icon: const Icon(Icons.more_vert_rounded)),
            ),
            Visibility(
              visible: _isShow,
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: (widget.propositions_bis.isNotEmpty)
                      ? ListView.builder(
                          itemCount: widget.propositions_bis.length,
                          itemBuilder: (context, i) {
                            return TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    reponse = widget.propositions_bis[i];
                                    if (widget.propositions_bis[i] ==
                                        widget.rightAnswer_bis) {
                                      print("Vrais");
                                    } else {
                                      print("Faux");
                                    }
                                  });
                                },
                                child: Text(widget.propositions_bis[i]));
                          })
                      : Column(children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.arrow_circle_down),
                                  hintText: 'Entrez votre réponse...',
                                  labelText: 'Réponse *',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Votre réponse est vide... !';
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Chargement...')),
                                  );
                                }
                              },
                              child: const Text('Répondre'),
                            ),
                          ),
                        ]),
                ),
              ),
            )
          ],
        ));
  }
}
