import 'package:bloc_to_do/models/note_model.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  List<Note> notes;
  NotesLoadedState(this.notes);
}

class AllNotesDeletedState extends NotesState {}

class CreateNoteState extends NotesState {
  List<Note> notes;
  CreateNoteState(this.notes);
}

class DeleteNoteState extends NotesState {
  DeleteNoteState(this.notes);

  List<Note> notes;
}

class UpdateNoteState extends NotesState {
  List<Note> notes;
  UpdateNoteState(this.notes);
}

class NotesErrorState extends NotesState {
  NotesErrorState(this.message);

  String message;
}

class ShowNotesInViewState extends NotesState {
  ShowNotesInViewState(this.inGrid);

  bool inGrid = true;
}
