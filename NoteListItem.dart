import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Note.dart';
import '../db/NoteDatabaseHelper.dart'; // Import DatabaseHelper
import 'NoteDetailScreen.dart'; // Import NoteDetailScreen
import 'EditNoteForm.dart'; // Import NoteEditScreen
import 'package:app_02/notesApp/api/NoteAPIService.dart';
class NoteListItem extends StatelessWidget {
  final Note note;
  final Function() onListUpdated; // Callback để thông báo cho list screen cập nhật

  const NoteListItem({
    Key? key,
    required this.note,
    required this.onListUpdated,
  }) : super(key: key);

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green.shade300; // Thấp
      case 2:
        return Colors.yellow.shade300; // Trung bình
      case 3:
        return Colors.red.shade300; // Cao
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NoteDatabaseHelper _dbHepler = NoteDatabaseHelper.instance;
    final NoteAPIService _apiService = NoteAPIService.instance;
    final formattedTime = DateFormat('dd/MM/yyyy HH:mm').format(note.createdAt);
    final formattedUpdateTime = note.modifiedAt != null ? DateFormat('dd/MM/yyyy HH:mm').format(note.modifiedAt!) : 'Chưa cập nhật';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: _getPriorityColor(note.priority), // Áp dụng màu nền cho Card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), // Sử dụng kích thước chữ mới
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2), // Sử dụng khoảng cách mới
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.content,
                  style: TextStyle(fontSize: 12), // Sử dụng kích thước chữ mới
                ),
              ),
            ),
            SizedBox(height: 4), // Sử dụng khoảng cách mới
            Text(
              'Tạo lúc: $formattedTime',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'Cập nhật: $formattedUpdateTime',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue, size: 18),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteForm(note: note), // Navigate directly to NoteEditScreen
                      ),
                    );
                    if (result == true) {
                      onListUpdated(); // Gọi callback để refresh list
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 18),
                  onPressed: () async {
                    // Hiển thị hộp thoại xác nhận
                    bool? confirmDelete = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Xác nhận xóa'),
                          content: const Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );

                    // Nếu người dùng xác nhận xóa
                    if (confirmDelete == true) {
                      await _dbHepler.deleteNote(note.id!);
                      onListUpdated(); // Gọi callback để refresh list
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}