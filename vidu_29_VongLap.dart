void main(){
  // Vòng lặp for
  for(var i=1; i<=5 ; i++)
  {
    print(1);
  }
  
  //Iterable : List, Set
  // for - in
  var names= ["Trần ","Thị","Hiền"];
  for(var name in names){
    print(name);
  }

  //Vòng lặp while
  var i =1;
  while(i<=5){
    print(i);
    i++;
  }

  //Vòng lặp do-while (thực hiện 1 lần)
  var x =1;
  do{
    print(x);
    x++;
  }
  while(x<=5);

  //break / countiue
  //break : Thoát ra khỏi vòng lặp ngay lập tức
  print("------");
   x =1;
  do{
    print(x);
    x++;
    if (x==3) break;
  }
  while(x<=5);

  //countinue : Bỏ qua phần còn lại của vòng lặp hiện tại và tiếp tục
  print("------");
   x =0;
  do{
     x++;
    if (x==3) continue;
    print(x);
  }
  while(x<=5);
}