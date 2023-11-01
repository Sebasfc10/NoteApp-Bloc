import 'package:bloc_to_do/models/note_model.dart';

abstract class NotesEvent {
  NotesEvent({this.notes});

  List<Note>? notes;
}

class GetAllNotesEvent extends NotesEvent {}

class CreateNoteEvent extends NotesEvent {
  Note note;
  CreateNoteEvent(this.note);
}

class DeleteNoteEvent extends NotesEvent {
  int id;
  DeleteNoteEvent(this.id);
}

class UpdateNoteEvent extends NotesEvent {
  UpdateNoteEvent(this.note);

  Note note;
}

class DeleteAllNotesEvent extends NotesEvent {}

class ShowNotesInGridEvent extends NotesEvent {}

class ShowNotesInListEvent extends NotesEvent {}

class CloseDBEvent extends NotesEvent {}
