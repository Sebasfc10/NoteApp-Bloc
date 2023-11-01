import 'dart:math';

import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:bloc_to_do/widgets/body_form_widget.dart';
import 'package:bloc_to_do/widgets/title_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _cuerpoController;
  late Note _note;
  late Size _size;
  final Random random = Random();

  @override
  void initState() {
    _tituloController = TextEditingController();
    _cuerpoController = TextEditingController();
    _tituloController.text = widget.note.titulo ?? '';
    _cuerpoController.text = widget.note.cuerpo ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _cuerpoController.dispose();
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
      appBar: AppBar(title: Text('Edita tus notas'), actions: [
        IconButton(
            onPressed: () {
              onTapSave();
            },
            icon: Icon(Icons.check))
      ]),
      body: Padding(
        padding: EdgeInsets.only(
          left: _size.height * 0.015,
          right: _size.height * 0.015,
          bottom: _size.height * 0.015,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TitleFormWidget(size: _size, controller: _tituloController),
              BodyFormWidget(size: _size, controller: _cuerpoController),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: listTags,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTapSave() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (widget.note != null) {
        updateNote();
        Navigator.pop(context, _note);
      } else {
        insertNote(context);
        Navigator.pop(context);
      }
    }
  }

  void updateNote() {
    _note = widget.note.copyWith(
      titulo: _tituloController.text,
      cuerpo: _cuerpoController.text,
    );
    context.read<NotesBloc>().add(UpdateNoteEvent(_note));
  }

  void insertNote(BuildContext context) {
    context.read<NotesBloc>().add(
          CreateNoteEvent(
            Note(
              id: widget.note.id,
              titulo: _tituloController.text,
              cuerpo: _cuerpoController.text,
            ),
          ),
        );
  }
}
