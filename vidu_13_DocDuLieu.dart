import 'dart:io';

void main()
{
  //Nhập tên
  stdout.write("Enter you name : ");
  String name = stdin.readLineSync()!;

  // Nhập tuổi
  stdout.write("Enter you age : ");
  int age = int.parse(stdin.readLineSync()!) ;

  print("Xin chào : $name, tuổi của bạn là: $age");

}