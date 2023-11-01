class Note {
  final int id;
  final String titulo;
  final String cuerpo;
  final List<Tags>? tags;

  Note(
      {required this.titulo,
      required this.cuerpo,
      List<Tags>? tags,
      required this.id})
      : tags = tags ?? <Tags>[];

  Note copyWith({
    int? id,
    String? titulo,
    String? cuerpo,
    List<Tags>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      cuerpo: cuerpo ?? this.cuerpo,
      tags: tags ?? this.tags,
    );
  }

  Note addTag(String tag) {
    final List<Tags> updatedTags = List.from(tags!)
      ..add(Tags(id: 0, nombreTag: tag));
    return Note(
      id: id,
      titulo: titulo,
      cuerpo: cuerpo,
      tags: updatedTags,
    );
  }
}

class Tags {
  final int id;
  final String nombreTag;

  Tags({required this.id, required this.nombreTag});

  Tags copyWith({
    int? id,
    String? nombreTag,
  }) {
    return Tags(id: id ?? this.id, nombreTag: nombreTag ?? this.nombreTag);
  }
}
