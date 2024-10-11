class TankStatus {
  final String name;
  final int dueDays;
  final List<String> status; // ["Before", "During", "After"]
  final bool isLocationAvailable;

  TankStatus({
    required this.name,
    required this.dueDays,
    required this.status,
    required this.isLocationAvailable,
  });
}
