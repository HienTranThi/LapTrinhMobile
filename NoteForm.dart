import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Thêm thư viện color picker
import '../model/Note.dart';
import '../db/NoteDatabaseHelper.dart';

class NoteForm extends StatefulWidget {
  final Note? note; // Để nhận note khi chỉnh sửa (có thể null nếu là tạo mới)

  const NoteForm({Key? key, this.note}) : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int _priority = 1; // Mặc định là mức độ ưu tiên thấp
  Color _selectedColor = Colors.white; // Màu mặc định là trắng
  List<String> _tags = [];
  final TextEditingController _tagController = TextEditingController();

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green.shade300; // Thấp
      case 2:
        return Colors.yellow.shade300; // Trung bình
      case 3:
        return Colors.red.shade300; // Cao
      default:
        return Colors.black; // Màu mặc định nếu không khớp
    }
  }

  @override
  void initState() {
    super.initState();
    // Nếu đang chỉnh sửa, điền dữ liệu vào form
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _priority = widget.note!.priority;
      if (widget.note!.color != null && widget.note!.color!.isNotEmpty) {
        _selectedColor = Color(int.parse(widget.note!.color!.substring(1), radix: 16));
      }
      if (widget.note!.tags != null) {
        _tags = List.from(widget.note!.tags!);
      }
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn màu sắc'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Chọn'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tagToRemove) {
    setState(() {
      _tags.remove(tagToRemove);
    });
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final content = _contentController.text;
      final createdAt = widget.note?.createdAt ?? DateTime.now();
      final modifiedAt = DateTime.now();
      final colorString = '#${_selectedColor.value.toRadixString(16).substring(2)}'; // Chuyển màu thành mã hex

      final newNote = Note(
        id: widget.note?.id, // Giữ nguyên ID nếu là chỉnh sửa
        title: title,
        content: content,
        priority: _priority,
        createdAt: createdAt,
        modifiedAt: modifiedAt,
        tags: _tags.isNotEmpty ? _tags : null,
        color: colorString,
      );

      final dbHelper = NoteDatabaseHelper.instance;
      if (widget.note == null) {
        // Tạo mới note
        final result = await dbHelper.insertNote(newNote);
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ghi chú đã được tạo'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi khi tạo ghi chú'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Cập nhật note
        await dbHelper.updateNote(newNote);
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(_priority); // Lấy màu dựa trên mức độ ưu tiên

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Thêm ghi chú mới' : 'Chỉnh sửa ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tiêu đề
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Tiêu đề',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Nội dung
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Chọn mức độ ưu tiên
              Text('Chọn mức độ ưu tiên:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: 1,
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                  ),
                  Text('Thấp'),
                  SizedBox(width: 10),
                  Radio<int>(
                    value: 2,
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                  ),
                  Text('Trung bình'),
                  SizedBox(width: 10),
                  Radio<int>(
                    value: 3,
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                  ),
                  Text('Cao'),
                ],
              ),
              SizedBox(height: 15),

              // Chọn màu sắc
              Text(
                'Chọn màu sắc:',
                style: TextStyle(fontWeight: FontWeight.bold, color: priorityColor), // Thay đổi màu dựa trên priority
              ),
              InkWell(
                onTap: _showColorPicker,
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Nhập các nhãn
              Text('Nhãn (có thể thêm/xóa):', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: InputDecoration(
                        labelText: 'Thêm nhãn',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addTag(), // Thêm nhãn khi nhấn Enter
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addTag,
                    child: Text('Thêm'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: _tags.map((tag) => Chip(
                  label: Text(tag),
                  onDeleted: () => _removeTag(tag),
                )).toList(),
              ),
              SizedBox(height: 20),

              // Nút Lưu/Cập nhật (đã được thêm vào AppBar)
            ],
          ),
        ),
      ),
    );
  }
}