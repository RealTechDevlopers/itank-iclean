class Items {
  // final int id;
  final String tankname;
  final int tanknumber;
  final int duedays;
  final int remainingdays;
  Items({
    // required this.id,
    required this.tankname,
    required this.tanknumber,
    required this.duedays,
    required this.remainingdays,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      // id: json['id'] ?? 0,
      tankname: json['tankname'] ?? 'Unknown Tank',
      tanknumber: json['tanknumber']?? 0,
      duedays: json['duedays'] ?? 0,
      remainingdays: json['Remainingdays'] ?? 0,
    );
  }
}
