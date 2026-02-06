abstract class NoteDetailState {}

class NoteDetailInitial extends NoteDetailState {}

class NoteDetailLoading extends NoteDetailState {}

class NoteDetailSuccess extends NoteDetailState {}

class NoteDetailError extends NoteDetailState {
  final String message;
  NoteDetailError(this.message);
}