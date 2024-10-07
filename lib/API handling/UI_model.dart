class Welcome {
  String message;
  List<Datum> data;

  Welcome({
    required this.message,
    required this.data,
  });

}

class Datum {
  String id;
  String name;
  String mobile;
  String address;
  String mail;
  String username;
  String password;
  Role role;
  String showQuantity;
  DateTime dt;
  String amcAmt;
  DateTime expDate;
  DateTime addDate;
  String validityDaysCount;
  String? amcValidity;
  String? siteMobile;
  String? file;
  String? pin;
  String? adduser;
  Gvtpvt gvtpvt;
  Dealer? dealer;
  Corporation? corporation;
  Municipality? municipality;
  TownPanchayat? townPanchayat;
  Zone? zone;
  String? ward;
  StateName? stateName;
  DistrictName? districtName;
  dynamic userscol;
  dynamic userscol1;
  dynamic userscol2;
  CategoryType? categoryType;
  String? unionName;
  String? panchayatName;
  String? sitePresidentName;
  String? sitePresidentMobileNum;
  String? sitePresidentPhoto;
  String? siteSecretaryName;
  String? siteSecretaryMobileNum;
  String? siteSecretaryPhoto;
  String? siteLatLang;
  String? siteOperatorName;
  String? siteOperatorMobileNum;
  String? siteOperatorPhoto;
  String? installedBy;
  DateTime? installedAt;
  dynamic installedEditAt;
  int profileProcessPercentage;
  int deviceProcessPercentage;
  int overallDevicePercentage;
  int deviceCount;
  int overallPercentage;
  List<TankDatum> tankData;

  Datum({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
    required this.mail,
    required this.username,
    required this.password,
    required this.role,
    required this.showQuantity,
    required this.dt,
    required this.amcAmt,
    required this.expDate,
    required this.addDate,
    required this.validityDaysCount,
    required this.amcValidity,
    required this.siteMobile,
    required this.file,
    required this.pin,
    required this.adduser,
    required this.gvtpvt,
    required this.dealer,
    required this.corporation,
    required this.municipality,
    required this.townPanchayat,
    required this.zone,
    required this.ward,
    required this.stateName,
    required this.districtName,
    required this.userscol,
    required this.userscol1,
    required this.userscol2,
    required this.categoryType,
    required this.unionName,
    required this.panchayatName,
    required this.sitePresidentName,
    required this.sitePresidentMobileNum,
    required this.sitePresidentPhoto,
    required this.siteSecretaryName,
    required this.siteSecretaryMobileNum,
    required this.siteSecretaryPhoto,
    required this.siteLatLang,
    required this.siteOperatorName,
    required this.siteOperatorMobileNum,
    required this.siteOperatorPhoto,
    required this.installedBy,
    required this.installedAt,
    required this.installedEditAt,
    required this.profileProcessPercentage,
    required this.deviceProcessPercentage,
    required this.overallDevicePercentage,
    required this.deviceCount,
    required this.overallPercentage,
    required this.tankData,
  });

}

enum CategoryType {
  CORPORATION,
  MUNICIPALITY,
  OTHERS,
  RURAL_DEVELOPMENT,
  RURAL_PANCHAYAT
}

enum Corporation {
  EMPTY,
  ERODE,
  NULL
}

enum Dealer {
  AKSHAY_BADANI_AB,
  DEALER_REAL_TECH_SYSTEMS_RTS,
  NULL,
  REAL_TECH_SYSTEMS_RTS,
  SRI_KUBERALAKSHMI_ENTERPRISES,
  SRI_KUBERALAKSHMI_ENTERPRISES_SKE
}

enum DistrictName {
  COIMBATORE,
  ERODE
}

enum Gvtpvt {
  GVT
}

enum Municipality {
  BHAVANI,
  EMPTY,
  NULL
}

enum Role {
  USER
}

enum StateName {
  TAMIL_NADU
}

class TankDatum {
  Device device;

  TankDatum({
    required this.device,
  });

}

class Device {
  String imei;
  String name;
  String? tankDetails;
  String? tankNumber;
  String tanksettings;
  String? deviceNameTamil;
  String? deviceNameUpdateBy;
  DateTime time;
  String tankNames;
  Type type;
  int? percentage;

  Device({
    required this.imei,
    required this.name,
    required this.tankDetails,
    required this.tankNumber,
    required this.tanksettings,
    required this.deviceNameTamil,
    required this.deviceNameUpdateBy,
    required this.time,
    required this.tankNames,
    required this.type,
    this.percentage,
  });

}

enum Type {
  TANK
}

enum TownPanchayat {
  AMMAPETTAI,
  EMPTY,
  NULL
}

enum Zone {
  EMPTY,
  NULL,
  PERUNDURAI,
  PER_1
}
