import 'package:bloc_to_do/bloc/notes_bloc_bloc.dart';
import 'package:bloc_to_do/bloc/notes_bloc_event.dart';
import 'package:bloc_to_do/models/note_model.dart';
import 'package:bloc_to_do/utils/colors.dart';
import 'package:bloc_to_do/widgets/body_form_widget.dart';
import 'package:bloc_to_do/widgets/title_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _cuerpoController = TextEditingController();
  List<String> _tags = [''];

  static int _noteId = 0;
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agrega una nueva nota'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                TagInputList(
                  tags: _tags,
                  onTagsChanged: (tags) {
                    setState(() {
                      _tags = tags;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final tagsList = _tags
                          .map((tag) => Tags(id: _noteId, nombreTag: tag))
                          .toList();
                      final note = Note(
                        id: _noteId,
                        titulo: _tituloController.text,
                        cuerpo: _cuerpoController.text,
                        tags: tagsList,
                      );
                      _noteId++;
                      context.read<NotesBloc>().add(CreateNoteEvent(note));
                      print(note);
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 8, left: 8),
                    child: Container(
                      width: _size.width,
                      height: _size.height / 20,
                      decoration: BoxDecoration(
                          color: AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Guardar Nota',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: AppColors.white,
                                    fontSize: _size.width * 0.050,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagInputList extends StatefulWidget {
  final List<String> tags;
  final Function(List<String>) onTagsChanged;

  const TagInputList(
      {Key? key, required this.tags, required this.onTagsChanged})
      : super(key: key);

  @override
  _TagInputListState createState() => _TagInputListState();
}

class _TagInputListState extends State<TagInputList> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Column(
      children: [
        for (int i = 0; i < widget.tags.length; i++)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  selectionControls: MaterialTextSelectionControls(),
                  initialValue: widget.tags[i],
                  maxLines: null,
                  onChanged: (text) {
                    widget.tags[i] = text;
                    widget.onTagsChanged(widget.tags);
                  },
                  decoration: InputDecoration(
                    hintText: 'Agrega etiquetas',
                    hintStyle:
                        Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: AppColors.lightGray,
                              fontSize: _size.width * 0.03,
                            ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: _size.width * 0.02,
                      horizontal: _size.width * 0.02,
                    ),
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: _size.width * 0.04,
                      ),
                ),
              ),
              if (i == widget.tags.length - 1)
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: IconButton(
                      color: AppColors.white,
                      iconSize: 30,
                      icon: Icon(Icons.add_rounded),
                      onPressed: () {
                        widget.tags.add('');
                        widget.onTagsChanged(widget.tags);
                      },
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
