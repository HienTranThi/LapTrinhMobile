import "package:flutter/material.dart";

class MyButton_3 extends StatelessWidget {
  const MyButton_3({super.key});

  @override
  Widget build(BuildContext context) {
    // Trả về Scaffold - widget cung cấp bố cụ Material Design cơ bản
    // Màn hình
    return Scaffold(
      //Tiêu đề của ứng dụng
      appBar: AppBar(
        title: Text("App 02"),
        // Màu nền của AppBar
        backgroundColor: Colors.green,
        // Độ nâng/ độ bóng của AppBar
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              print("b1");
            },
            icon: Icon(Icons.search),
          ), // IconButton
          IconButton(
            onPressed: () {
              print("b2");
            },
            icon: Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              print("b3");
            },
            icon: Icon(Icons.more_vert),
          ), // IconButton
        ], // AppBar
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),

            //Khóa nút nhấn
            ElevatedButton(
              onPressed:  null,//Khóa lại
              child: Text("ElevatedButton", style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                //Màu nền
                backgroundColor: Colors.lightGreen,
                //Màu của các nội dung bên trong
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

                  // Padding
                  padding: EdgeInsets.symmetric(
                    horizontal: 20, // Chiều ngang
                    vertical: 15   // Chiều dọc
                  ),
                  // elevate
                elevation: 10,
              )
            ),

            SizedBox(height: 50),
            ElevatedButton(
                onPressed:  (){
                  print("Pressed");},
                onLongPress: (){
                  print("Long Pressed");},//Khóa lại
                child: Text("ElevatedButton", style: TextStyle(fontSize: 24)),
                style: ElevatedButton.styleFrom(
                  //Màu nền
                  backgroundColor: Colors.lightGreen,
                  //Màu của các nội dung bên trong
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),

                  // Padding
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, // Chiều ngang
                      vertical: 15   // Chiều dọc
                  ),
                  // elevate
                  elevation: 10,
                )
            ),

            SizedBox(height: 50),
            // InkWell không phải là button nhưng cho phép tạo hiệu ứng gợn sóng(ripple effect) khi nhấn vào bất kì widget
            InkWell(
              onTap: (){
                print("InkWell được nhấn !");
              },
              onDoubleTap:(){
                print("InkWell được nhấn 2 lần liên tiếp!");
              } ,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  border : Border.all(color: Colors.blue),
                ),
                child: Text("Button tùy chỉnh với InkWell"),
              ),
            )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Message");
        },
        child: const Icon(Icons.add_ic_call),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá nhân"),
        ],
      ),
    );
  }
}
