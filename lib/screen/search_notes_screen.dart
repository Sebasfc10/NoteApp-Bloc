import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_state.dart';
import 'package:bloc_to_do/bloc/search_notes_bloc.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:bloc_to_do/widgets/build_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchNotesScreen extends StatefulWidget {
  const SearchNotesScreen({super.key});

  @override
  State<SearchNotesScreen> createState() => _SearchNotesScreenState();
}

class _SearchNotesScreenState extends State<SearchNotesScreen> {
  final _searchController = TextEditingController();
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final notesState = context.read<NotesBloc>().state;
    List<Note> notes = [];

    if (notesState is CreateNoteState) {
      notes = notesState.notes;
    } else if (notesState is UpdateNoteState) {
      notes = notesState.notes;
    } else if (notesState is NotesLoadedState) {
      notes = notesState.notes;
    } else if (notesState is DeleteNoteState) {
      notes = notesState.notes;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CupertinoSearchTextField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: _size.width * 0.04,
                  ),
              placeholder: 'Buscar notas',
              controller: _searchController,
            ),
            GestureDetector(
              onTap: () {
                final query = _searchController.text;
                context
                    .read<NotesSearchBloc>()
                    .add(SearchNotesEvent(query, notes));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 8, left: 8),
                  child: Container(
                    width: _size.width,
                    height: _size.height / 22,
                    decoration: BoxDecoration(
                        color: AppColors.darkGray,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Buscar',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: AppColors.white,
                              fontSize: _size.width * 0.042999,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(child: BlocBuilder<NotesSearchBloc, NotesStateSearch>(
                builder: (context, state) {
              if (state is ResultNotesState) {
                final searchResults = state.notes;
                return BuilListWidget(
                  itemCount: searchResults,
                  dissmissIcon: false,
                );
              }
              return Center(child: Text('No se encontraron resultados.'));
            }))
          ],
        ),
      ),
    );
  }
}
