part of 'search_notes_bloc.dart';

abstract class NotesStateSearch {}

class NotesInitialStateSearch extends NotesStateSearch {}

class NotesLoadingStateSearch extends NotesStateSearch {}

class NotesLoadedStateSearch extends NotesStateSearch {
  List<Note> notes;
  NotesLoadedStateSearch(this.notes);
}

class ResultNotesState extends NotesStateSearch {
  List<Note> notes;
  ResultNotesState(this.notes);
}
