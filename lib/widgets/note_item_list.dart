import 'dart:math';

import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteItemList extends StatefulWidget {
  final Size size;
  final Note note;
  final VoidCallback ontap;
  final bool dissmissIcon;
  const NoteItemList(
      {super.key,
      required this.size,
      required this.note,
      required this.ontap,
      required this.dissmissIcon});

  @override
  State<NoteItemList> createState() => _NoteItemListState();
}

final Random random = Random();
late Size _size;

class _NoteItemListState extends State<NoteItemList> {
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    List<Widget> listTags = widget.note.tags!
        .map((tag) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  width: _size.width / 6,
                  height: _size.height / 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors
                          .list[random.nextInt(AppColors.list.length)]),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                        child: Text(
                      tag.nombreTag,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: AppColors.darkGray,
                          ),
                    )),
                  )),
            ))
        .toList();
    return Card(
      color: AppColors.list[random.nextInt(AppColors.list.length)],
      child: InkWell(
        onTap: widget.ontap,
        splashColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.all(widget.size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.titulo,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.darkGray,
                          fontSize: widget.size.width * 0.050,
                        ),
                  ),
                  Row(
                    children: listTags,
                  )
                ],
              ),
              widget.dissmissIcon
                  ? Container(
                      width: _size.width / 9,
                      height: _size.height / 20,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<NotesBloc>()
                                    .add(DeleteNoteEvent(widget.note.id));
                              },
                              icon: const Icon(Icons.close))))
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
