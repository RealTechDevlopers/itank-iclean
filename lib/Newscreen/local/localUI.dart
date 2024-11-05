import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LocalUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('duedays'.tr),
            ElevatedButton( //ta_ES
              onPressed: () {
                var newLocale = Get.locale == const Locale('en', 'US')
                    ? const Locale('ta', 'ES')
                    : const Locale('en', 'US');
                Get.updateLocale(newLocale); // Change locale
              },
              child: const Text('Change Language'),
            ),
          ],
        ),
      ),
    );
  }
}

