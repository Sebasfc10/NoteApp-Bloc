import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/screen/watch_note_screen.dart';
import 'package:bloc_to_do/widgets/note_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuilListWidget extends StatefulWidget {
  final List<Note> itemCount;
  final bool dissmissIcon;
  const BuilListWidget(
      {super.key, required this.itemCount, this.dissmissIcon = true});

  @override
  State<BuilListWidget> createState() => _BuilListWidgetState();
}

late Size _size;

class _BuilListWidgetState extends State<BuilListWidget> {
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: widget.itemCount.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 0, right: 12, left: 12),
          child: NoteItemList(
            dissmissIcon: widget.dissmissIcon,
            size: _size,
            note: widget.itemCount[index],
            ontap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WatchNoteScreen(note: widget.itemCount[index])));
            },
          ),
        );
      },
    );
  }
}
