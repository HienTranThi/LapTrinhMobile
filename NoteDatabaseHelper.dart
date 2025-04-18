import 'package:app_02/notesApp/model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabaseHelper {
  static final NoteDatabaseHelper instance = NoteDatabaseHelper._init();
  static Database? _database;

  NoteDatabaseHelper._init();

  // Getter cho database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes_database.db');
    return _database!;
  }

  // Khởi tạo cơ sở dữ liệu và tạo bảng khi lần đầu mở
  Future<Database> _initDB(String filePath) async {

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  // Tạo bảng ghi chú trong cơ sở dữ liệu
  Future _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        priority INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        modifiedAt TEXT NOT NULL,
        tags TEXT,
        color TEXT
      )
    ''');

    await _insertSampleData(db);
  }

  // Hàm chèn dữ liệu mẫu vào cơ sở dữ liệu
  Future _insertSampleData(Database db) async {
    final List<Map<String, dynamic>> sampleNotes = [
      {
        'title': 'Ghi chú 1',
        'content': 'Đây là ghi chú mẫu số 1.',
        'priority': 1,
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String(),
        'tags': 'Tag1, Tag2',
        'color': 'blue',
      },
      {
        'title': 'Ghi chú 2',
        'content': 'Đây là ghi chú mẫu số 2.',
        'priority': 2,
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String(),
        'tags': 'Tag3, Tag4',
        'color': 'green',
      },
      {
        'title': 'Ghi chú 3',
        'content': 'Đây là ghi chú mẫu số 3.',
        'priority': 3,
        'createdAt': DateTime.now().toIso8601String(),
        'modifiedAt': DateTime.now().toIso8601String(),
        'tags': 'Tag5, Tag6',
        'color': 'red',
      },
    ];

    // Chèn các ghi chú mẫu vào cơ sở dữ liệu
    for (final noteData in sampleNotes) {
      await db.insert('notes', noteData);
    }
  }
  // Đóng kết nối database
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Thêm một ghi chú mới
  Future<int> insertNote(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  // Lấy tất cả ghi chú
  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;
    final result = await db.query('notes');
    return result.map((map) => Note.fromMap(map)).toList();
  }

  // Lấy ghi chú theo ID
  Future<Note?> getNoteById(int id) async {
    final db = await instance.database;
    final maps = await db.query('notes', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  // Cập nhật ghi chú
  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Xóa ghi chú theo ID
  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Lấy ghi chú theo mức độ ưu tiên
  Future<List<Note>> getNotesByPriority(int priority) async {
    final db = await instance.database;
    final result = await db.query('notes', where: 'priority = ?', whereArgs: [priority]);

    return result.map((map) => Note.fromMap(map)).toList();
  }

  // Tìm kiếm ghi chú theo từ khóa
  Future<List<Note>> searchNotes(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    return result.map((map) => Note.fromMap(map)).toList();
  }


}
