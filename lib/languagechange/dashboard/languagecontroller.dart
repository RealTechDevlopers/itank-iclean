// language_controller.dart
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;
  final box = GetStorage();
  final List<Map<String, String>> languages = [
    {'name': 'English', 'locale': 'en_US'},
    {'name': 'Tamil', 'locale': 'ta_ES'},
    {'name': 'Hindi', 'locale': 'hi_IN'},
  ];


  Locale get locale {
    String? localeCode = languages
        .firstWhere((lang) => lang['name'] == selectedLanguage.value)['locale'];
    if (localeCode != null) {
      var localeList = localeCode.split('_');
      return Locale(localeList[0], localeList[1]);
    }
    return const Locale('en', 'US'); // Default locale
  }

  @override
  void onInit() {
    super.onInit();
    // Load stored language preference, if any
    final box = GetStorage();
    String? storedLanguage = box.read('language');
    if (storedLanguage != null) {
      selectedLanguage.value = storedLanguage;
      _updateLocale(storedLanguage);
    }
  }
  // Change language and save to storage
  void changeLanguage(String language) {
    selectedLanguage.value = language;
    box.write('language', language); // Save selected language
    _updateLocale(language);
  }

  void _updateLocale(String language) {
    String? localeCode = languages.firstWhere((lang) => lang['name'] == language)['locale'];
    if (localeCode != null) {
      var localeList = localeCode.split('_');
      Get.updateLocale(Locale(localeList[0], localeList[1]));
    }
  }
}
