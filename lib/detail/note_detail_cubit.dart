import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/database/note_repository.dart';
import 'note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  final NoteRepository _repository;

  NoteDetailCubit(this._repository) : super(NoteDetailInitial());

  Future<void> addNote(String title, String content) async {
    emit(NoteDetailLoading());
    try {
      await _repository.addNote(title, content);
      emit(NoteDetailSuccess());
    } catch (e) {
      emit(NoteDetailError("Не удалось сохранить"));
    }
  }

  Future<void> updateNote(int id, String title, String content) async {
    emit(NoteDetailLoading());
    try {
      await _repository.updateNote(id, title, content);
      emit(NoteDetailSuccess());
    } catch (e) {
      emit(NoteDetailError("Не удалось обновить"));
    }
  }
}
