import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/database/note_database.dart';
import '../domain/database/note_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NoteRepository _repository;

  HomeCubit(this._repository) : super(HomeLoading()) {
    _init();
  }

  void _init() {
    _repository.watchNotes().listen(
      (notes) {
        emit(HomeLoaded(notes));
      },
      onError: (error) {
        emit(HomeError("Ошибка: $error"));
      },
    );
  }

  Future<void> deleteNote(int id) async {
    await _repository.deleteNote(id);
  }
}
