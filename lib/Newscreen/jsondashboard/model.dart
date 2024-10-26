class TankDataResponse {
  String status;
  String message;
  List<Tank> data;

  TankDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TankDataResponse.fromJson(Map<String, dynamic> json) {
    return TankDataResponse(
      status: json['status'],
      message: json['message'],
      data: List<Tank>.from(json['data'].map((item) => Tank.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
    };
  }
}

class Tank {
  String name;
  String imei;
  String devicename;
  String categoryType;
  String percentage;
  String unionName;
  String panchayatName;
  String type;
  String capacity;
  String username;
  String tankNumberImages;
  String tankNumber;
  String beforeImg;
  String duringImg;
  String afterImg;
  String updatedAt;
  int? daysCountAfterClean;
  String tankLatlong;
  String id;

  Tank({
    required this.name,
    required this.imei,
    required this.devicename,
    required this.categoryType,
    required this.percentage,
    required this.unionName,
    required this.panchayatName,
    required this.type,
    required this.capacity,
    required this.username,
    required this.tankNumberImages,
    required this.tankNumber,
    required this.beforeImg,
    required this.duringImg,
    required this.afterImg,
    required this.updatedAt,
    this.daysCountAfterClean,
    required this.tankLatlong,
    required this.id,
  });

  factory Tank.fromJson(Map<String, dynamic> json) {
    return Tank(
      name: json['name'],
      imei: json['imei'],
      devicename: json['devicename'],
      categoryType: json['categoryType'],
      percentage: json['percentage'],
      unionName: json['unionName'],
      panchayatName: json['panchayatName'],
      type: json['type'],
      capacity: json['capacity'],
      username: json['username'],
      tankNumberImages: json['tankNumberImages'] ?? "",
      tankNumber: json['tankNumber'] ?? "",
      beforeImg: json['beforeImg'] ?? "",
      duringImg: json['duringImg'] ?? "",
      afterImg: json['afterImg'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      daysCountAfterClean: json['daysCountAfterClean'],
      tankLatlong: json['tank_latlong'] ?? "",
      id: json['id'] ?? "",
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imei': imei,
      'devicename': devicename,
      'categoryType': categoryType,
      'percentage': percentage,
      'unionName': unionName,
      'panchayatName': panchayatName,
      'type': type,
      'capacity': capacity,
      'username': username,
      'tankNumberImages': tankNumberImages,
      'tankNumber': tankNumber,
      'beforeImg': beforeImg,
      'duringImg': duringImg,
      'afterImg': afterImg,
      'updatedAt': updatedAt,
      'daysCountAfterClean': daysCountAfterClean,
      'tank_latlong': tankLatlong,
    };
  }
}
