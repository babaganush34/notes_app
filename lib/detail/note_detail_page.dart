import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/database/note_database.dart';
import 'package:notes_app/main.dart';
import 'note_detail_cubit.dart';
import 'note_detail_state.dart';

class NoteDetailPage extends StatelessWidget {
  final Note? note;

  const NoteDetailPage({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteDetailCubit(noteRepository),
      child: _NoteDetailView(note: note),
    );
  }
}

class _NoteDetailView extends StatefulWidget {
  final Note? note;

  const _NoteDetailView({this.note});

  @override
  State<_NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<_NoteDetailView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteDetailCubit, NoteDetailState>(
      listener: (context, state) {
        if (state is NoteDetailSuccess) {
          Navigator.pop(context);
        }
        if (state is NoteDetailError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.note == null ? "Новая заметка" : "Редактировать",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage('images/assets/note_pisture.png')),
              Text(
                'Название',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hint: Text('введите название задачи'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Описание',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    controller: _contentController,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hint: Text('введите название задачи'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<NoteDetailCubit, NoteDetailState>(
                builder: (context, state) {
                  if (state is NoteDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final title = _titleController.text;
                        final content = _contentController.text;

                        if (title.isEmpty) return;

                        if (widget.note == null) {
                          context.read<NoteDetailCubit>().addNote(
                            title,
                            content,
                          );
                        } else {
                          context.read<NoteDetailCubit>().updateNote(
                            widget.note!.id,
                            title,
                            content,
                          );
                        }
                      },
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
