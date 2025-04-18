import "package:flutter/material.dart";

class MyText extends StatelessWidget{
  const  MyText({super.key});
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
          //Tạo 1 khoảng cách
          const SizedBox(height: 58,),
          //Text cơ bản
          const Text("Trần Thị Hiền"),
          const SizedBox(height: 20,),

          const Text(" Xin chào các bạn !!",
          textAlign: TextAlign.center,

          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
            letterSpacing: 1.5,
          ),),
          const SizedBox(height: 20,),
          //Text cơ bản
          const Text("Flutter là một SDK phát triển ứng dụng di động nguồn mở được tạo ra bởi Google!!",
            textAlign: TextAlign.center,
            maxLines: 2,// Số dòng tối đa
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              letterSpacing: 1.5,
            ),)
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