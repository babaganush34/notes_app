import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/database/note_repository.dart';
import 'domain/database/note_database.dart';
import 'home/home_cubit.dart';
import 'home/home_page.dart';

late NoteRepository noteRepository;
late NoteDatabase noteDatabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  noteDatabase = NoteDatabase();
  noteRepository = NoteRepositoryImpl(noteDatabase);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => HomeCubit(noteRepository))],
      child: MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF2F2F7),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
