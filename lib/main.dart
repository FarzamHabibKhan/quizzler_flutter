import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black54,
      body: QuizApp(),
    ),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  // List with Widget datatype
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();
    bool userAnswer = true;

    setState(() {
      // If the end of the quiz is reached,
      // 1. show alert using rflutter_alert package.
      // 2. reset the question number.
      // 3. empty out the scoreKeeper.
      if(quizBrain.isFinished()){
        Alert(context: context,
            title: "Finished",
            desc: "You've reached the end of the Quiz.").show();
        quizBrain.resetQuestionNumber();
        scoreKeeper.clear();
      }else {
        if (correctAnswer == userPickedAnswer) {
          scoreKeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              )
          );
        } else {
          scoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              )
          );
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Expanded(
            flex: 7,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {

                  checkAnswer(true);
                },
                child: Text('True'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  textStyle: TextStyle(fontSize: 25) ,
                ),
              ),
            ),
            ),
          Expanded(
            flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: (){
                    checkAnswer(false);
                    },
                  child: Text('False'),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      textStyle: TextStyle(fontSize: 25) ,
                  ),
                ),
              ),
          ),
          Row(
            children: scoreKeeper,
          )
        ]
    );
  }
}

// question1: 'you can lead a cow down but not upstairs,', false,
// question2: 'Approximately one quarter of human bones are in the feet.',true,
// question3: 'A slug\'s blood is green.', true,


