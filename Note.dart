import 'dart:convert';
class Note {
  int? id; // Định danh duy nhất của ghi chú
  String title; // Tiêu đề của ghi chú
  String content; // Nội dung chi tiết của ghi chú
  int priority; // Mức độ ưu tiên (1: Thấp, 2: Trung bình, 3: Cao)
  DateTime createdAt; // Thời gian tạo ghi chú
  DateTime modifiedAt; // Thời gian cập nhật ghi chú gần nhất
  List<String>? tags; // Danh sách các nhãn (tags) tùy chọn
  String? color; // Mã màu của ghi chú (dạng hex hoặc tên màu)

  // Constructor
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.createdAt,
    required this.modifiedAt,
    this.tags,
    this.color,
  });

  // Named constructor để tạo đối tượng Note từ Map
  Map<String, dynamic> toData() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'tags': tags != null ? tags!.join(',') : null, // Lưu tags dưới dạng chuỗi
      'color': color,
    };
  }

  Map<String, dynamic> toMap() {
    return toData();
  }
  // Chuyển đối tượng Note thành chuỗi JSON
  String toJSON() {
    return jsonEncode(toData());
  }

  // Thay đổi trong Note.fromMap()
  factory Note.fromJSON(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      priority: map['priority'],
      createdAt: DateTime.parse(map['createdAt']),
      modifiedAt: DateTime.parse(map['modifiedAt']),
      tags: map['tags'] != null
          ? (map['tags'] is String
          ? map['tags'].split(',')
          : List<String>.from(map['tags']))
          : null, // Tách chuỗi tags thành danh sách
      color: map['color'],
    );
  }
// Thay đổi trong Note.fromMap()
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      priority: map['priority'],
      createdAt: DateTime.parse(map['createdAt']),
      modifiedAt: DateTime.parse(map['modifiedAt']),
      tags: map['tags'] != null
          ? (map['tags'] is String
          ? map['tags'].split(',')
          : List<String>.from(map['tags']))
          : null, // Tách chuỗi tags thành danh sách
      color: map['color'],
    );
  }

  // Phương thức tạo bản sao (copy) của đối tượng Note với các thuộc tính có thể thay đổi
  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? priority,
    DateTime? createdAt,
    DateTime? modifiedAt,
    List<String>? tags,
    String? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      tags: tags ?? this.tags,
      color: color ?? this.color,
    );
  }

  // Phương thức biểu diễn chuỗi của đối tượng Note
  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, priority: $priority, createdAt: $createdAt, modifiedAt: $modifiedAt, tags: $tags, color: $color}';
  }
}