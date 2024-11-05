import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iclean/languagechange/Splash/splashcon.dart';
class Splash1 extends GetView<fistcontroller> {
  Splash1({super.key});
  @override
  Widget build(BuildContext context) {
    final fistcontroller controller = Get.put(fistcontroller());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Images/iclean.png'),
            const SizedBox(height: 20),
            Text(
              "iClean",
              style: GoogleFonts.averiaSerifLibre(
                color: Colors.green,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            const Text("V.1.0",style: TextStyle(color: Colors.green,fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
