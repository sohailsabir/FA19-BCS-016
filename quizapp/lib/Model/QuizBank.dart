import 'package:quizapp/Model/Question.dart';

class QuizBank{
  int _questionNumber=0;
  List<Question>_questionList=[
    Question('The letter H is between letters G and J on a keyboard', true),
    Question('Camels have three sets of eyelashes', true),
    Question('There are five zeros in one hundred thousand', true),
    Question('There are stars and zigzags on the flag of America', false),
    Question('If you add the two numbers on the opposite sides of dice together, the answer is always 7', true),
    Question('New York is nicknamed \'The Big Orange\'', false),
    Question('The moon is just 50 percent of the mass of Earth.', false),
    Question('Human eyes contain a small blind spot where the optic nerve passes through the retina.', true),
    Question('Is China the largest country in the world?', false),
    Question('Spiders have 6 legs. Is it true or false?', false),
    Question('5+9 = 14', true),
    Question('Honeybees are the fastest flying insect.', false),
    Question('There is no railway system in Iceland.', true),
    Question('Humans have 4 senses.', false),

  ];
  void nextQuestion()
  {
    if(_questionNumber<_questionList.length-1)
      {
        _questionNumber++;
      }
  }
  String? getQuestionText()
  {
    return _questionList[_questionNumber].questionText;
  }
  bool? getQuestionAnswer()
  {
    return _questionList[_questionNumber].questionAnswer;
  }
  bool isFinished()
  {
    if(_questionNumber>=_questionList.length-1)
      {
        return true;
      }
    else{
      return false;
    }
  }
  void reset()
  {
    _questionNumber=0;
  }
}