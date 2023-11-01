import 'package:bloc/bloc.dart';
import 'package:bloc_to_do/models/note_model.dart';

part 'search_notes_event.dart';
part 'search_notes_state.dart';

class NotesSearchBloc extends Bloc<NotesEventSearch, NotesStateSearch> {
  List<Note> _notes = [];
  NotesSearchBloc() : super(NotesInitialStateSearch()) {
    on<GetAllNotesSearchEvent>((event, emit) {
      emit(NotesLoadedStateSearch(List.from(_notes)));
    });

    on<SearchNotesEvent>((event, emit) {
      List<Note> notesList = event._notes;
      List<Note> filteredList = [];
      filteredList = notesList.where((note) {
        final lowerQuery = event.query.toLowerCase();
        return note.titulo.toLowerCase().contains(lowerQuery) ||
            note.tags!.any(
                (tag) => tag.nombreTag.toLowerCase().contains(lowerQuery)) ||
            note.cuerpo.toLowerCase().contains(lowerQuery) ||
            note.id.toString().contains(lowerQuery);
      }).toList();
      if (event.query.isEmpty) {
        emit(ResultNotesState(notesList));
      } else {
        emit(ResultNotesState(filteredList));
      }
    });
  }
}
