

import 'package:quizapp/Model/MutipleChoice.dart';

class QuizBrain2{
  int _qNumber=0;
  List<MultiChoice>_questionBank=[
    MultiChoice('Brass gets discoloured in air because of the presence of which of the following gases in air?', 'Oxygen', 'Hydrogen sulphide', 'Carbon dioxide', 'Nitrogen', 'Hydrogen sulphide'),
    MultiChoice('Which of the following is a non metal that remains liquid at room temperature?', 'Phosphorous', 'Bromine', 'Chlorine', 'Helium', 'Bromine'),
    MultiChoice(' What do you call a computer on a network that requests files from another computer?', 'A client', 'A host', 'A router', 'A web server', 'A client'),
    MultiChoice(' Google (www.google.com) is a:', 'Search Engine', 'Number in Math', 'Directory of images', 'Chat service on the web', 'Search Engine'),
    MultiChoice('Which is not an Internet protocol?', 'HTTP', 'FTP', 'STP', 'IP', 'STP'),
    MultiChoice(' "www" stands for:', 'World Wide Web', ' World Wide Wares', ' World Wide Wait', ' World Wide War', 'World Wide Web'),
    MultiChoice('The lens used in a simple microscope is', 'Concave', 'Convex', 'Cylindrical', 'None', 'Convex'),
    MultiChoice('Which of the following is not a primary colour', 'Red', 'Blue', 'Green', 'Yellow', 'Yellow'),
    MultiChoice('The word “Islam” literally means', 'peace', 'religion', 'direction', 'submission', 'submission'),
    MultiChoice('What is the total number of Ghazwas fought by Muslims?', ' 7', '17', ' 27', '37', '27'),
  ];
  void nextQuestion()
  {
    if(_qNumber<_questionBank.length-1)
    {
      _qNumber=_qNumber+1;
    }
  }
  String? getQuestionText()
  {
    return _questionBank[_qNumber].questionText;
  }
  String? getOP1()
  {
    return _questionBank[_qNumber].op1;
  }
  String? getOP2()
  {
    return _questionBank[_qNumber].op2;
  }
  String? getOP3()
  {
    return _questionBank[_qNumber].op3;
  }
  String? getOP4()
  {
    return _questionBank[_qNumber].op4;
  }
  String? getAnwerText()
  {
    return _questionBank[_qNumber].answerText;
  }
  bool isfinished()
  {
    if(_qNumber>= _questionBank.length-1)
    {
      return true;
    }
    else{
      return false;
    }
  }
  void reset() {
    _qNumber = 0;
  }
  int getQuestionnumber()
  {
    return _qNumber+1;
  }


}