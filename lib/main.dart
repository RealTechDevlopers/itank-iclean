import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'Newscreen/Camera/Test3/geotag.dart';
void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
       // initialBinding: CaptureBinding(),
      debugShowCheckedModeBanner: false,  
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CameraAppView()
    );
  }
}