import 'package:app_02/notesApp/db/NoteDatabaseHelper.dart';
import 'package:app_02/notesApp/view/EditNoteForm.dart';
import "package:flutter/material.dart";
import 'package:app_02/notesApp/model/Note.dart';
import 'package:app_02/notesApp/view/NoteDetailScreen.dart';
import 'package:app_02/notesApp/view/NoteListItem.dart';
import 'NoteForm.dart';
import 'package:app_02/notesApp/api/NoteAPIService.dart';

enum NoteSortOption { priority, time }

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late Future<List<Note>> _notesFuture;
  final NoteDatabaseHelper _dbHelper = NoteDatabaseHelper.instance;
  final NoteAPIService _apiService = NoteAPIService.instance;
  bool _isGridView = false; // Mặc định hiển thị dạng danh sách
  String _searchQuery = '';
  int? _filterPriority; // Lọc theo mức độ ưu tiên (null để hiển thị tất cả)
  NoteSortOption _sortOption = NoteSortOption.time; // Mặc định sắp xếp theo thời gian

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes({NoteSortOption? sortOption}) async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      if (_searchQuery.isNotEmpty) {
        _notesFuture = _dbHelper.searchNotes(_searchQuery);
      } else if (_filterPriority != null) {
        _notesFuture = _dbHelper.getNotesByPriority(_filterPriority!);
      } else {
        _notesFuture = _dbHelper.getAllNotes().then((notes) {
          if (sortOption == NoteSortOption.priority) {
            notes.sort((a, b) => b.priority.compareTo(a.priority));
          } else {
            notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          }
          return notes;
        });
      }
      if (sortOption != null) {
        _sortOption = sortOption;
      }
    });
  }
  /*Future<void> _refreshNotes({NoteSortOption? sortOption}) async {
    setState(() {
      _notesFuture = Future.value([]); // Khởi tạo _notesFuture để tránh lỗi
    });
    try {

      setState(() {
        if (_searchQuery.isNotEmpty) {
          _notesFuture = _apiService.searchNotes(_searchQuery); // Đảm bảo dòng này tồn tại
        } else if (_filterPriority != null) {
          _notesFuture = _apiService.getNotesByPriority(_filterPriority!);
        } else {
          _notesFuture = _apiService.getAllNotes().then((notes) {
            if (sortOption == NoteSortOption.priority) {
              notes.sort((a, b) => b.priority.compareTo(a.priority));
            } else {
              notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            }
            return notes;
          });
        }
        if (sortOption != null) {
          _sortOption = sortOption;
        }
      });
    } catch (e) {
      // ... (xử lý lỗi)
    }
  }*/
  // Hàm để xác định màu sắc dựa trên mức độ ưu tiên
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

  // Hàm để chuyển đổi giữa chế độ hiển thị grid và list
  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  // Hàm để hiển thị dialog lọc theo ưu tiên
  void _showFilterPriorityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lọc theo ưu tiên'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Tất cả'),
                onTap: () {
                  setState(() {
                    _filterPriority = null;
                    _refreshNotes(sortOption: _sortOption);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Thấp'),
                onTap: () {
                  setState(() {
                    _filterPriority = 1;
                    _refreshNotes(sortOption: _sortOption);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Trung bình'),
                onTap: () {
                  setState(() {
                    _filterPriority = 2;
                    _refreshNotes(sortOption: _sortOption);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Cao'),
                onTap: () {
                  setState(() {
                    _filterPriority = 3;
                    _refreshNotes(sortOption: _sortOption);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
// Hàm để hiển thị bottom sheet tùy chọn sắp xếp
  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Sắp xếp theo thời gian'),
              onTap: () {
                _refreshNotes(sortOption: NoteSortOption.time); // Truyền sortOption khi chọn
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sắp xếp theo mức độ ưu tiên'),
              onTap: () {
                _refreshNotes(sortOption: NoteSortOption.priority); // Truyền sortOption khi chọn
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              setState(() {
                _filterPriority = null; // Đặt lại bộ lọc ưu tiên
              });
              _refreshNotes(); // Gọi _refreshNotes mà không có tham số sortOption
            },
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: (){
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'filter') {
                _showFilterPriorityDialog();
              }
              else if (value == 'sort') {
                _showSortOptions();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'filter',
                child: Text('Lọc theo ưu tiên'),
              ),
              // Thêm tùy chọn sắp xếp vào menu
              const PopupMenuItem<String>(
                value: 'sort',
                child: Text('Sắp xếp'),
              ),
            ],
          ),
        ],
        // Thanh tìm kiếm
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm ghi chú...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _refreshNotes(sortOption: _sortOption);
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có ghi chú nào'));
          } else {
            final notes = snapshot.data!;
            return _isGridView
                ? GridView.builder(
              key: ValueKey('grid_view'), // Thêm key này
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:  1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteListItem(
                  note: note,
                  onListUpdated: (){
                    _refreshNotes();
                    setState(() {

                    });
                  },// Truyền _refreshNotes
                );
              },
            )
                : ListView.builder(
              key: ValueKey('list_view'), // Thêm key này
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return SizedBox( // Bọc NoteListItem trong SizedBox
                  height: 155.0, // Đặt chiều cao cố định cho mỗi item (điều chỉnh nếu cần)
                  child: NoteListItem(
                    note: note,
                    onListUpdated:() {
                      _refreshNotes();
                      setState(() {});
                    },// Truyền _refreshNotes
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator()); // Dòng này có thể không cần thiết ở đây
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=> NoteForm(note: null),
            ),
          );
          if(result == true){
            _refreshNotes();
          }
        },
        child : const Icon(Icons.add),
      ),
    );
  }
}