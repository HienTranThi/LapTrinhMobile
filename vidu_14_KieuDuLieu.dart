void main()
{
  int x = 100;

  // double : số thực
  double y = 100.5;

  //num: chứa số nguyên or sô thực
  num z = 10;
  num t = 10.75;


  // chuyển chuỗi sang số nguyên
   var one = int.parse('1');
   print(one==1?'TRUE':'FLASE');
  //Chuyển chuỗi sang số thực
  var onePointOne = double.parse('1.1');
  print(onePointOne==1.1);

  //Số nguyên => Chuỗi
  String oneAsString = 1.toString();
  print(oneAsString);

  //Số nguyên => Chuỗi
  String piAsString = 3.14159.toStringAsFixed(2);
  print(piAsString);
}