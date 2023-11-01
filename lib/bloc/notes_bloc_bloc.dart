import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/bloc/notes_bloc_state.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<Note> _notes = [];

  NotesBloc() : super(NotesInitialState()) {
    on<GetAllNotesEvent>((event, emit) {
      emit(NotesLoadedState(List.from(_notes)));
    });

    on<CreateNoteEvent>((event, emit) {
      _notes.add(event.note);
      emit(CreateNoteState(List.from(_notes)));
    });

    on<DeleteNoteEvent>((event, emit) {
      _notes.removeWhere((note) => note.id == event.id);
      emit(DeleteNoteState(List.from(_notes)));
    });

    on<UpdateNoteEvent>((event, emit) {
      final index = _notes.indexWhere((note) => note.id == event.note.id);
      if (index != -1) {
        _notes[index] = event.note;
      }
      emit(UpdateNoteState(List.from(_notes)));
    });
  }
}
