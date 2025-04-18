void main(){
  // Định nghĩa:
  // - Runes là tập hợp các điểm mã Unicode của 1 chuỗi
  // - Dùng để xử lí các kí tự Unicode đăc biệt như emoji,kí tự
  // - Mỗi kí tự Unicode được biểu diễn bằng 1 số nguyên
  // cách khai báo:
  String str = 'Hello';
  Runes runes1 = str.runes;

  Runes runes2 = Runes('\u2665'); // trái tim
  print(runes2);
  Runes runes3 = Runes('\u{1F600}'); // emoji cười
  print(runes3);
 // các pthuc và thuộc tính
 // 1.Chuyển đổi:
 // Từ Runes sang string
 String emoji = String.fromCharCode(0x1F600);
 print(emoji);
 String symbol = String.fromCharCode(0x2665);
 print(symbol);
 //2.Xử lý :
 print(runes1.length); //sl điểm mã
 print(runes1.first); // Điểm mã đầu tiên
 print(runes1.last); // Điểm mã cuối cùng

 // Duyệt qua từng điểm mã
 runes1 ='Xin chào  , tôi rất bạn!'.runes;
 runes1.forEach((int rune){
  print('Unicode: $rune, Kí tự: ${String.fromCharCode(rune)}');
 });
 //Kiểm tra
 print(runes1.isEmpty); //Ktra Rỗng
 print(runes1.isNotEmpty); //Ktra không rỗng


}