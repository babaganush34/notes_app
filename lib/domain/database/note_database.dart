import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'notes.dart';
part 'note_database.g.dart';

@DriftDatabase(tables: [Notes])
class NoteDatabase extends _$NoteDatabase {
  NoteDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  Stream<List<Note>> watchAllNotes() {
    return select(notes).watch();
  }

  Future<int> updateNote(int id, NotesCompanion data) {
    return (update(notes)..where((t) => t.id.equals(id))).write(data);
  }

  Future<int> deleteNote(int id) {
    return (delete(notes)..where((t) => t.id.equals(id))).go();
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'notes.db'));
      return NativeDatabase(file);
    });
  }
}
