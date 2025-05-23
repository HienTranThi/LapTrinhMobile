import "package:flutter/material.dart";

class MyAppBar extends StatelessWidget{
  const  MyAppBar({super.key});
    @override
  Widget build(BuildContext context) {
    // Trả về Scaffold - widget cung cấp bố cụ Material Design cơ bản
      // Màn hình
      return Scaffold(
        //Tiêu đề của ứng dụng
        appBar: AppBar(
          title: Text("App 02"),
// Màu nền của AppBar
      backgroundColor: Colors.blue,
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

      body: Center(child: Text("Nội dung chính")),

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