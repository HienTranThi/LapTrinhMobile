import "package:flutter/material.dart";

class MyButton extends StatelessWidget{
  const  MyButton({super.key});
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
          ) ,
          IconButton(
            onPressed: () {
              print("b3");
            },
            icon: Icon(Icons.more_vert
            ),
          ) // IconButton
        ], // AppBar
      ),

      body: Center(child: Column(
        children: [
        SizedBox(height: 50,),
          ElevatedButton(
              onPressed: (){print("ElevatedButton");},
              child: Text("ElevatedButton",style: TextStyle(fontSize: 24),)),
          SizedBox(height: 20,),
          //TextButton là một button phẳng
          // Không có đổ bóng
          // Thường dùng cho các hành động thử yếu hoặc trong các thành phần như Dialog
          TextButton(
              onPressed: (){print("TextButton");},
              child: Text("TextButton",style: TextStyle(fontSize: 24),)),
          SizedBox(height: 20,),

          //OutlineButton là button có viền bao quanh , k màu nền và phù hợp cho các thay thế
          OutlinedButton(
              onPressed: (){print("OutlineButton");},
              child: Text("OutlineButton",style: TextStyle(fontSize: 24),)),
          SizedBox(height: 20,),

          //IconButton là button chỉ gồm icon, k có văn bản và thường dùng trong Appbar,
          IconButton(
              onPressed: (){print("IconButton");},
              icon: Icon(Icons.favorite)),
          SizedBox(height: 20,),

          //FloatingActionButton là 1 button hình tròn, nổi trên giao diện, thường dùng cho hành động chính của màn hình
          FloatingActionButton(
              onPressed: (){print("OutlineButton");},
            child: Icon(Icons.add),
          )
        ],
      )),

      floatingActionButton: FloatingActionButton(
        onPressed: (){print("Message");},
        child: const Icon(Icons.add_ic_call),),


      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá nhân"),
      ]),


    );
  }
}