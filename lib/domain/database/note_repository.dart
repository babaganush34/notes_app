import 'note_database.dart';
import 'package:drift/drift.dart';

abstract class NoteRepository {
  Future<void> addNote(String title, String content);
  Future<void> deleteNote(int id);
  Future<void> updateNote(int id, String title, String content);
  Stream<List<Note>> watchNotes();
}

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatabase _database;

  NoteRepositoryImpl(this._database);

  @override
  Future<void> addNote(String title, String content) async {
    await _database.insertNote(
      NotesCompanion(title: Value(title), content: Value(content)),
    );
  }

  @override
  Future<void> deleteNote(int id) async {
    await _database.deleteNote(id);
  }

  @override
  Future<void> updateNote(int id, String title, String content) async {
    await _database.updateNote(
      id,
      NotesCompanion(title: Value(title), content: Value(content)),
    );
  }

  @override
  Stream<List<Note>> watchNotes() {
    return _database.watchAllNotes();
  }
}
