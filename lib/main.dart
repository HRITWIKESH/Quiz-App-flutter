import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizb = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Quizpage(),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  //List<String> question = [
  //'You can lead a cow down stairs but not up stairs.',
  //'Approximately one quarter of human bones are in the feet.',
  //  'A slug\'s blood is green.',
  //];
  //int questnumber = 0;
//  List<bool> answer = [false, true, true];
/*  List<Question> questionbook = [
    Question(a: 'You can lead a cow down stairs but not up stairs.', b: false),
    Question(
        a: 'Approximately one quarter of human bones are in the feet.',
        b: true),
    Question(a: 'A slug\'s blood is green.', b: true)
  ];*/
  List<Icon> scorekeeper = [];
  void checkans(bool userans) {
    bool correct = quizb.getQuestionA();
    setState(() {
      if (quizb.isFinished() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "Reached the last question.")
            .show();

        quizb.reset();
        scorekeeper = [];
      } else {
        if (userans == correct) {
          scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizb.nextQ();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizb.getQuestionT(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                /*bool correct = quizb.getQuestionA();
                if (correct == true) {
                  print('got wright');
                } else {
                  print('wrong');
                }
                setState(() {
                  quizb.nextQ();
                });*/
                checkans(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                /*bool correct = quizb.getQuestionA();
                if (correct == true) {
                  print('got wright');
                } else {
                  print('wrong');
                }
                setState(() {
                  quizb.nextQ();
                });*/
                checkans(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
