class TankModel {
  final int id;
  final String name;
  final int capacity;
  final String location;

  TankModel({
    required this.id,
    required this.name,
    required this.capacity,
    required this.location,
  });

  factory TankModel.fromJson(Map<String, dynamic> json) {
    return TankModel(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      location: json['location'],
    );
  }
}
