import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iclean/Newscreen/jsondashboard/model.dart';
import 'Newscreen/Camera/Test4/set.dart';
import 'Newscreen/Dashboard/Dashboard.dart';
import 'Newscreen/Login/Login.dart';
import 'Newscreen/Splash/splash.dart';
import 'Newscreen/Tamildashboard/tamildashboard.dart';
import 'Newscreen/local/local.dart';
import 'Newscreen/local/localUI.dart';
import 'demo.dart';
import 'languagechange/Splash/splashUI.dart';
import 'languagechange/dashboard/languagecontroller.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final LanguageController langController = Get.put(LanguageController());
    final box = GetStorage();
    String? savedLanguage = box.read('language');
    Locale initialLocale = Locale('en', 'US'); // Default locale

    // Check saved language and set the initial locale accordingly
    if (savedLanguage != null) {
      if (savedLanguage == 'Tamil') {
        initialLocale = Locale('ta', 'ES');
      } else if (savedLanguage == 'Hindi') {
        initialLocale = Locale('hi', 'IN');
      }
    }
    //  langController.locale=initialLocale
    return Obx(
      () => GetMaterialApp(
        translations: AppTranslations(),
        locale: langController.locale, // Initial locale
        fallbackLocale: Locale('ta', 'Es'), // Fallback locale
        // supportedLocales: const [
        //   Locale('en', 'US'),
        //   Locale('ta', 'ES'),
        // ],
        // initialBinding: CaptureBinding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/Splash1',
        getPages: [
          // New screens
          GetPage(name: '/Splash1', page: () => Splash1()),

          GetPage(name: '/New', page: () => New()),

          //Old screens
          GetPage(name: '/SplashScreen', page: () => Splash()),
          GetPage(name: '/LocalUI', page: () => LocalUI()),
          GetPage(
              name: '/DashboardScreen',
              page: () =>
                  DashboardScreen()), // Splash screen as the first route
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
                        tankName: "",
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
                        id: '',
                        nextCleaningDate: '',
                        lastCleaningDate: ''),
                  )), // Login screen route
          //  GetPage(name: '/CleaningCalendar', page: () => CleaningCalendar(username: '',)),  // Dashboard or next screen route
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: Splash()
      ),
    );
  }
}
