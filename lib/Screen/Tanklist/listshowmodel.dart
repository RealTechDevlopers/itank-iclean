// class Tank{
//   final String tankName;
//   final int dueDays;
//   Tank({required this.tankName,required this.dueDays});
//
//   factory Tank.fromJson(Map<String, dynamic> json){
//     return Tank(
//         tankName: json['tankName'],
//       dueDays: int.tryParse(json['dueDays'].toString()) ?? 0,
//     );
//   }
//   // Map<String,dynamic> toJson(){
//   //   return{
//   //     'tankName' : tankName,
//   //     'dueDays': dueDays,
//   //   };
//   // }
// }