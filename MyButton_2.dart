import "package:flutter/material.dart";

class MyButton_2 extends StatelessWidget {
  const MyButton_2({super.key});

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
            ElevatedButton(
              onPressed: () {
                print("ElevatedButton");
              },
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
            SizedBox(height: 20),
            OutlinedButton(
                onPressed: ()
                {print("OutlineButton");},
                child: Text("OutlineButton",style: TextStyle(fontSize: 24)),
             style: OutlinedButton.styleFrom(
               backgroundColor: Colors.orange,
               foregroundColor: Colors.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(100),
               side: BorderSide(color: Colors.deepOrange,width: 2),
               ),
               padding: EdgeInsets.symmetric(
                 horizontal: 20, vertical: 15),
               elevation: 10,
             )
            ),
            SizedBox(height: 50),
            // InkWell không phải là button nhưng cho phép tạo hiệu ứng gợn sóng(ripple effect) khi nhấn vào bất kì widget
            InkWell(
              onTap: (){
                print("InkWell được nhấn !");
              },
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
