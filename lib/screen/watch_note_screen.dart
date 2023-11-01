import 'dart:math';

import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/screen/update_note_screen.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:flutter/material.dart';

class WatchNoteScreen extends StatefulWidget {
  final Note note;
  const WatchNoteScreen({super.key, required this.note});

  @override
  State<WatchNoteScreen> createState() => _WatchNoteScreenState();
}

class _WatchNoteScreenState extends State<WatchNoteScreen> {
  late Note _note;
  late Size _size;
  final Random random = Random();

  @override
  void initState() {
    _note = widget.note;
    super.initState();
  }

  @override
  void dispose() {
    _note = widget.note;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    List<Widget> listTags = widget.note.tags!
        .map((tag) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  width: _size.width / 3,
                  height: _size.height / 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors
                          .list[random.nextInt(AppColors.list.length)]),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                        child: Text(
                      tag.nombreTag,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: _size.width * 0.050,
                            color: AppColors.darkGray,
                          ),
                    )),
                  )),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            width: _size.width / 8,
            height: _size.height,
            decoration: BoxDecoration(
                color: AppColors.darkGray,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: IconButton(
                onPressed: () async {
                  final updateNote = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateNoteScreen(note: _note)));
                  if (updateNote != null) {
                    setState(() {
                      _note = updateNote;
                    });
                  }
                },
                icon: Icon(Icons.edit_outlined),
              ),
            ),
          ),
        )
      ]),
      body: Padding(
        padding: EdgeInsets.only(
          top: _size.height * 0.02,
          left: _size.height * 0.035,
          right: _size.height * 0.035,
        ),
        child: _buildBody(listTags),
      ),
    );
  }

  Widget _buildBody(List<Widget> lista) {
    return Column(
      children: [
        _buildTitleText(),
        SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: _buildNoteText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: lista,
          ),
        )
      ],
    );
  }

  Widget _buildTitleText() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        _note.titulo ?? '',
        maxLines: null,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.white,
              fontSize: _size.width * 0.08,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  _buildNoteText() {
    return Text(
      _note.cuerpo ?? '',
      maxLines: null,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }
}
