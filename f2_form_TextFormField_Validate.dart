import 'package:flutter/material.dart';

class TextFormFieldd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_TextFormFieldSate();

}
class _TextFormFieldSate extends State<TextFormFieldd>{
  // Sử dụng Globla key để truy cập from
  final _formKey =  GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordlController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _obscurePassword = true;

  String? _name;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Form cơ bản"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // Form là widget chứa và quản lí các trường nhập liệu
        // Key được sử dụng để truy cập vào trạng thái của Form
        // Phương thức validate() kiểm tra tính hợp lệ của tất cả trường
        // Phương thức save() gọi hàm onSaved của môi trường
        // Phương thức reset() đặt lại giá trị của tất cả trường
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextFormField là phiên bản mở rộng của TextField
                // Validator là hàm kiểm tra tính hợp lệ của dữ liệu
                // Controller cho phép truy cập và điều khiển giá trị
                // obscureText cho phép ẩn văn bản
                // AutovalidateMode điều khiển thời điểm validation được kích hoạt
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Họ và tên",
                    hintText: "Nhập họ và tên của bạn",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (vaule){
                    _name = vaule;
                  },
                  autovalidateMode : AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value==null|| value.isEmpty){
                      return'Vui lòng nhập họ và tên';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),  // InputDecoration
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),
                TextFormField(
                  controller:_emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'example@gmail.com',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),  // InputDecoration
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Password field
                TextFormField(
                  controller: _passwordlController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Xác nhận mật khẩu
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                    hintText: 'Nhập lại mật khẩu của bạn',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng xác nhận mật khẩu';
                    }
                    if (value != _passwordlController.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 30,),
                Row(
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Xin chào $_name"))
                        );
                      }
                    }, child: Text("Submit")),

                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: (){
                      _formKey.currentState!.reset();
                      setState(() {
                        _name = null;
                      });
                    }, child: Text("Reset")),

                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
