import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iclean/Newscreen/jsondashboard/model.dart';
import 'Newscreen/Camera/Test4/set.dart';
import 'Newscreen/Dashboard/Dashboard.dart';
import 'Newscreen/Login/Login.dart';
import 'Newscreen/Splash/splash.dart';
import 'Newscreen/Tamildashboard/tamildashboard.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: CaptureBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/DashboardScreen',
      getPages: [
        GetPage(
            name: '/SplashScreen',
            page: () => Splash()),
        GetPage(
            name: '/DashboardScreen',
            page: () => DashboardScreen()), // Splash screen as the first route
        GetPage(
            name: '/CleaningCalendar',
            page: () => CleaningCalendar(
                  username: '',
                )), // Splash screen as the first route
        GetPage(
            name: '/LogScreen',
            page: () => LoginScreen()), // Login screen route
        GetPage(
            name: '/ImageapiScreen',
            page: () => ImageapiScreen(
                  tankName: '',
                  tank: Tank(
                      name: "",
                      imei: "",
                      devicename: "",
                      categoryType: "",
                      percentage: "",
                      unionName: "",
                      panchayatName: "",
                      type: "",
                      capacity: "",
                      username: '',
                      tankNumberImages: '',
                      tankNumber: '',
                      beforeImg: '',
                      duringImg: '',
                      afterImg: '',
                      updatedAt: '',
                      tankLatlong: '',
                      id: ''),
                )), // Login screen route
        //  GetPage(name: '/CleaningCalendar', page: () => CleaningCalendar(username: '',)),  // Dashboard or next screen route
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Splash()
    );
  }
}
