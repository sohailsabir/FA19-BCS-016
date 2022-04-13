import 'dart:math';

class BMICalculator{

  BMICalculator({required this.height,required this.weight});
   final int height;
   final int weight;
   double _bmi=0.0;



  String? CalculateBMI()
  {
    _bmi=weight/pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }


  String? GetResultText() {
    if(_bmi>=25)
    {
      return 'OverWeight';
    }
    else if(_bmi>=18.5)
    {
      return 'Normal';
    }
    else {
      return 'UnderWeight';
    }
  }
  String? getInterpretation(){
    if(_bmi>=25)
    {
      return 'You have a higher than normal body weight. Try to exercise more.';
    }
    else if(_bmi>=18.5)
    {
      return 'You have normal body weight. Good Job!';
    }
    else {
      return 'You have lower than normal body weight. You can eat bit more.';
    }

  }
}