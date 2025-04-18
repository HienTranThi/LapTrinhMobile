void main()
{
 
List<String> list1 =['A','B','C'];// tạo list theo kiểu trực tiếp
var list2 =[1,2,3];//sd var
List<String> list3=[]; //list rỗng
var list4 = List<int>.filled(3,0); //list có kích thước cố định 
print(list4);

//1. Thêm 1 phần tử
list1.add('D'); //Thêm 1 phần tử
list1.addAll(['A','c']);
list1.insert(0,'Z');
list1.insertAll(1,['1', '0']);
print(list1);

//2. Xóa ptu bên trong list
list1.remove('A'); // Xóa ptu có gtri A
list1.removeAt(0); // Xóa Ptu tại vị trí 0
list1.removeLast; // Xóa ptu tại vị trí cuối
list1.removeWhere((e)=>e=='B'); //Xóa theo điều kiện
list1.clear();
print(list1);

// 3. Truy cập phần tử:
print(list2[0]);//Lấy phần tử tại vị trí 0
print(list2.first) ;//Lấy phần tử đầu tiên
print(list2.last);//Lấy phần tử cuối
print(list2.length);//Độ dài 

// 4. Kiểm tra :
print(list2.isEmpty);//ktra rỗng
print('List 3: ${list3.isNotEmpty?'Không rỗng':'rỗng'}');
print(list4.contains(1));
print(list4.contains(0));
print(list4.indexOf(0));
print(list4.lastIndexOf(0));

// 5. Biến đổi :
list4 = [2,1,3,0,4];
print(list4);
list4.sort();//tăng dần
print(list4);
list4.reversed;//Đảo ngược
list4=list4.reversed.toList();
print(list4);

//7.Cắt và nối
var subList = list4.sublist(1,3);//Cắt 1 subList từ 1->3
print(subList);
var str_joined = list4.join(",");
print(str_joined);

// 8.Duyệt các ptu bên trong List
list4.forEach((element) {
    print(element);
});

}