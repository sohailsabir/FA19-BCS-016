

class GuessCalculator{

  GuessCalculator({required this.GussNum,required this.maxNum,required this.minNum});
   final int GussNum;
   final int maxNum;
   final int minNum;



  String ExactNumber()
  {
    return GussNum.toStringAsFixed(0);
  }


  String? GetResultText() {
    if(GussNum-5==minNum && GussNum+5==maxNum)
    {
      return '“Perfect';
    }
    else if(maxNum>GussNum)
    {
      return '“You are TOO Heigh';
    }
    else {
      return 'You are TOO Low';
    }
  }

}