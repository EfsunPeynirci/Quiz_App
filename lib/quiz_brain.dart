import 'question.dart';

class QuizBrain{
  int _questionNumber = 0;

  List <Question> _questionBank = [
    Question("Turkey is in Africa. Is it true or false?", false),
    Question("Thailand's capital city Bangkok. Is it true or false?", true),
    Question("China is the most populated country in the world.", true),
    Question("Turkey's capital is Istanbul. Is it true or false?", false),
    Question("Thomas edison invented the light bulb. Is it true or false?", true),
    Question("The world is made up of 7 continents. Is it true or false?", true),
  ];

  String getQuestionText(){
    return _questionBank[_questionNumber].questionText!;
  }

  bool getCorrectAnswer(){
    return _questionBank[_questionNumber].questionAnswer!;
  }

  //Bu sayede son soruda sorulduktan sonra o soruda durulması saglandi. Eger yapılmasaydı son sorudayu da bilindikten sonra hic soru kalinmadigindan
  //ekrandan kırmızı renkte olacak sekilde hata cikacakti.
  void nextQuestion(){
    if (_questionNumber < _questionBank.length - 1){
      _questionNumber ++;
    }
  }

  bool isFinished(){
    if (_questionNumber >= _questionBank.length - 1){
      return true;
    }
    else{
      return false;
    }
  }

  void reset(){
    _questionNumber = 0;
    _questionBank.shuffle();
  }
}

//List <String> questions = [
//  "Turkey is in Africa. Is it true or false?",
//  "Thailand's capital city Bangkok. Is it true or false?",
//  "The founder of englistestbank is Seyfo, Efsun and Burhan family. Is it true or false?",
//  ];
//  int questionNumber = 0;
// List <bool> answers = [false, true, true];
// Question q1 = Question("Turkey is in Africa. Is it true or false?", false);
//Bu sekilde yukaridaki gibi yapmak yerine questionBank yazarak olusturduk.
