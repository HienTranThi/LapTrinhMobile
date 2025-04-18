import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Note.dart';
import 'EditNoteForm.dart'; // Import màn hình chỉnh sửa

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('dd/MM/yyyy HH:mm').format(note.createdAt);
    final formattedUpdateTime = note.modifiedAt != null ? DateFormat('dd/MM/yyyy HH:mm').format(note.modifiedAt!) : 'Chưa cập nhật';

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteForm(note: note),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              note.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Nội dung:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              note.content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Thời gian tạo: $formattedTime',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Cập nhật lần cuối: $formattedUpdateTime',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Mức độ ưu tiên:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${note.priority}',
              style: TextStyle(fontSize: 16),
            ),
            // Bạn có thể thêm hiển thị cho tags và color nếu muốn
            if (note.tags != null && note.tags!.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Tags:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                note.tags!.join(', '),
                style: TextStyle(fontSize: 16),
              ),
            ],
            if (note.color != null && note.color!.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Màu:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 50,
                height: 50,
                color: Color(int.parse(note.color!.substring(1), radix: 16)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}