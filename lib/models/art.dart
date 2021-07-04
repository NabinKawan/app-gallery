class Art {
  int id;
  String name;
  String description;
  String imagePath;

  Art({this.id, this.name, this.description, this.imagePath});

  factory Art.fromMap(int id, Map<String, dynamic> map) => Art(
      id: id,
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'discription': description,
        'imagePath': imagePath
      };
}
