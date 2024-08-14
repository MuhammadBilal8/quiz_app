import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //Different ways for open a screen
  //1:
  /*Widget? activeScreen;
  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }*/
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen'; //2

  void switchScreen() {
    setState(() {
      // activeScreen = const QuestionsScreen();  //1
      activeScreen = 'questions-screen'; //2
    });
  }

  void chooseAnswers(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results_screen';
      });
    }
  }

  void restartQuiz() {
      setState(() {
        selectedAnswers = [];
        activeScreen = 'questions-screen';
      });
  }

  @override
  Widget build(BuildContext context) {
    //3-start
    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswers);
    } //3-end
    if (activeScreen == 'results_screen') {
      screenWidget = ResultsScreen(chosenAnswers: selectedAnswers, restartQuiz: restartQuiz,);
    }
    return MaterialApp(
      home: Scaffold(
        // body: GradientContainer(
        //   colors: [
        //     Color.fromARGB(255, 78, 13, 151),
        //     Color.fromARGB(255, 107, 15, 168),
        //   ],
        // ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: screenWidget //1,3
            //2-start:
            // activeScreen == 'start-screen'
            //     ? StartScreen(switchScreen)
            //     : const QuestionsScreen(), //2-end
            ),
      ),
    );
  }
}
