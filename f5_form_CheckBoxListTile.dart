import 'package:flutter/material.dart';

class CheckBoxListTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DropdownSate();
}

class _DropdownSate extends State<CheckBoxListTile> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _obscurePassword = true;

  String? _name;
  String? _selectedCity;
  final _cities = ['Hà Nội', 'TP. HCM', 'Đà Nẵng', 'Huế', 'Cần Thơ'];
  String? _gender;
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form cơ bản"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn giới tính';
                  }
                  return null;
                },
                initialValue: _gender,
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 20,
                        children: [
                          RadioListTile<String>(
                            title: Text('Nam'),
                            value: 'male',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                                state.didChange(value);
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text('Nữ'),
                            value: 'female',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                                state.didChange(value);
                              });
                            },
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  if (!RegExp(r'^0\d{9}$').hasMatch(value)) {
                    return 'Số điện thoại không hợp lệ';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),


              TextFormField(
                controller: _passwordController,
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

              SizedBox(height: 20),
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
                  if (value != _passwordController.text) {
                    return 'Mật khẩu không khớp';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Thành phố",
                  border: OutlineInputBorder(),
                ),
                value: _selectedCity,
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value as String?;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn thành phố';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text("Đồng ý với điều khoản của công ty ABC."),
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _name = _fullnameController.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Xin chào $_name")),
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),

                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _name = null;
                        _selectedCity = null;
                        _gender = null;
                        _isAgreed = false;
                      });
                    },
                    child: Text("Reset"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
