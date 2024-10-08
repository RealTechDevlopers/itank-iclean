class Item {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  Item({required this.id, required this.name, required this.description,required this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
