class Column {
  final String id;
  final String label;
  final String type;

  Column(this.id, this.label, this.type);

  Column.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        type = json['type'];
}
