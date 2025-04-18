/*
 */
void main()
{
  var s1 ='Tran Thi Hien';
  var s2 ='Hien.vn';

  //Chèn gtri cua một biểu thức, biến vào trong chuỗi :$(...)
  double diemToan = 9.75;
  double diemVan = 9.55;
  var s3 = 'Xin chao $s1. bạn đã đạt tổng điểm là: ${diemVan+diemToan}';
  print(s3);

  //Tạo ra chuỗi nằm ở nhiều dòng
  var s4='''
    Dòng 1
    Dòng 2
    Dòng 3

  ''';

  var s6 =' Đây là một đoạn \n văn bản!';
  print(s6);

  var s7 = r'Đây là một đoạn \n văn bản!';//raw giữ nguyên chuỗi không thay đổi gì cả
  print(s7);

  var s8="chuỗi 1 "+ "chuỗi2";
  print(s8);

  var s9='Chuỗi'
        "này"
        "là"
        "một chuỗi";
  print(s9);
}