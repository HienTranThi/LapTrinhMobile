/*
Typedefs trong Dart là một cách ngắn gọn để tạo các alias (bí danh) cho các loại  
dữ liệu. Điều này giúp mã nguồn trở nên rõ ràng và dễ đọc hơn, đặc biệt khi làm việc  
với các loại dữ liệu phức tạp.  
*/
typedef IntList = List <int>;
typedef ListMapper <x > = Map <x,List<x>>;
void main(){
  IntList l1 = [1,2,3,4,5];
  print(l1);

  IntList l2 = [1,2,3,4,5,6,7];
    print(l2);
    Map <String , List<String>> m1={};//Khá dài
    ListMapper<String> m2 ={}; //m1 và m2 là cùng 1 kiểu
    
    // Vidu
    ListMapper<String> vdu ={
      'A' :['Phở','Cơm'],
      'B' :['Bún']
    }; 
    print(vdu);
}