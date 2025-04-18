import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../db/NoteDatabaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:app_02/notesApp/view/NoteForm.dart';

class EditNoteForm extends StatefulWidget {
  final Note note;

  const EditNoteForm({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteFormState createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _priority = widget.note.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final updatedNote = widget.note.copyWith(
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        modifiedAt: DateTime.now(),
      );

      final dbHelper = NoteDatabaseHelper.instance;
      await dbHelper.updateNote(updatedNote);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ghi chú đã được cập nhật'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // Trả về true để báo hiệu cập nhật thành công
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
              SizedBox(height: 16.0),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Mức độ ưu tiên',
                  border: OutlineInputBorder(),
                ),
                value: _priority,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Thấp')),
                  DropdownMenuItem(value: 2, child: Text('Trung bình')),
                  DropdownMenuItem(value: 3, child: Text('Cao')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _priority = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}