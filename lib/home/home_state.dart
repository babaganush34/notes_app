import '../domain/database/note_database.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Note> notes;

  HomeLoaded(this.notes);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
