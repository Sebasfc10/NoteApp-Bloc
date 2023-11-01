import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/bloc/notes_bloc_state.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/screen/add_note_screen.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:bloc_to_do/widgets/build_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> _listNote;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notas - Memos'),
          ),
          body: _buildBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddNoteScreen()));
            },
            child: const Icon(
              Icons.add,
              color: AppColors.darkGray,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
            if (state is NotesLoadingState || state is NotesInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotesLoadedState) {
              _listNote = state.notes;
              return BuilListWidget(itemCount: _listNote, dissmissIcon: true);
            } else if (state is AllNotesDeletedState) {
              _listNote = [];
              return BuilListWidget(itemCount: _listNote, dissmissIcon: true);
            } else if (state is DeleteNoteState) {
              _listNote = state.notes;
              return BuilListWidget(itemCount: _listNote, dissmissIcon: true);
            } else if (state is CreateNoteState) {
              _listNote = state.notes;
              return BuilListWidget(itemCount: _listNote, dissmissIcon: true);
            } else if (state is UpdateNoteState) {
              _listNote = state.notes;
              return BuilListWidget(itemCount: _listNote, dissmissIcon: true);
            } else if (state is NotesErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('algo salio mal'),
            );
          }),
        ),
      ],
    );
  }
}
