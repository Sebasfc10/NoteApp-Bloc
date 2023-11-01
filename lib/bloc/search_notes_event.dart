part of 'search_notes_bloc.dart';

abstract class NotesEventSearch {
  NotesEventSearch({this.notes});

  List<Note>? notes;
}

class GetAllNotesSearchEvent extends NotesEventSearch {}

class SearchNotesEvent extends NotesEventSearch {
  String query;
  List<Note> _notes;
  SearchNotesEvent(this.query, this._notes);
}
