import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain =  QuizBrain();

void main() {
  runApp(Quiz());
}

//Arayüz kısmındaki ana yerin değişmeyen kısmı
class Quiz extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding
              (
              padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: QuizPage()
            ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {

  //Burada scoreKeeper adli bir liste olusturduk. Bu listemizi özellestirerek widget yazdik. Yani buraya artik int, String vb. yazamayiz.
  //Ornegin ben String' lerle ilgili liste yapacaksam List <String> myStrings = [] yazabilirim.
  //Kisacasi listelerde icine ne yazagina dikkat et, turlerine dikkat et.

  List <Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true){
        Alert(
            context: context,
           type: AlertType.warning,
          title: "Finished!",
          desc: "You have reached the end of the quiz!",
          buttons: [
            DialogButton(
                child: Text(
                    "Try Again",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              color: Colors.yellow,
            ),

            DialogButton(
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => exit(0),
              color: Colors.blue,
            ),
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      //Eger daha son soruya gelinmediyse diger soruya devam eder. Cevaplanan sorunun da yanlıs veya dogru olduguyla ilgili ikonu asagida verir.
      else{
        if (userPickedAnswer == correctAnswer){
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        }
        else{
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
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
          flex: 5,  //Eger bunu yapmasaydık true ve false butonları cok buyuk olacakti. flex' d ebiz sunu demis olduk, text butonlardan 5 kat daha fazla yer kaplasın
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                    quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,  //uzun metin girilse de metnin ortalayacak sekilde ekranda olmasını sagliyor
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            )
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
                onPressed: (){
                checkAnswer(true);
                },
                child: Text('True'),
            ),
          ),
        ),

        Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: (){
                  checkAnswer(false);
                },
                child: Text('False'),
              ),
            ),
        ),

        Row(
          children: scoreKeeper, //Normalde buraya children : [] acip icine ikonları yazmistik. Onlari duzenleyip bu hale getirdik.
        ),
      ],
    );
  }
}

