import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              /*
              TextField là widget cho phép người dùng
              nhập văn bản thông qua bàn phím.
              Đây là thành phần thiết yếu trong hầu hết các ứng dụng,
              từ biểu mẫu đăng nhập, tìm kiếm,
              đến nhập liệu trong các ứng dụng phức tạp.
               */
              TextField(
                decoration: InputDecoration(
                  labelText: "Họ và tên",
                  hintText: " Nhập vào họ và tên của bạn",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Example@gmail.com",
                  helperText: "Nhập vào email cá nhân",
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.clear),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.lime
                ),
              ),
              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                    labelText: "Phone",
                    hintText: "***67890",
                    helperText: "Nhập vào sdt",
                    prefixIcon: Icon(Icons.phone),
                    suffixIcon: Icon(Icons.clear),
                    border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                    labelText: "Ngày sinh",
                    hintText: "Nhập vào ngày sinh của bạn",
                    border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    hintText: "Nhập vào ngày sinh của bạn",
                    border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.datetime,
                obscureText: true,
                obscuringCharacter: '*',
              ),


      SizedBox(height: 30),
      TextField(
        onChanged: (value){
          print("Đang nhập: $value");
        },
        onSubmitted: (value){
          print("Đã hoàn thành nội dung: $value");
        },
        decoration: InputDecoration(
            labelText: "Câu hỏi bí mật",
            border: OutlineInputBorder()
        ),
        keyboardType: TextInputType.datetime,
      ),
            ],
          ),
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
