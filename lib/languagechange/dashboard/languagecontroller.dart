import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;
  final List<Map<String, String>> languages = [
    {'name': 'English', 'locale': 'en_US'},
    {'name': 'Tamil', 'locale': 'ta_ES'},
    {'name': 'Hindi', 'locale': 'hi_IN'},
  ];

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    String? storedLanguage = box.read('language');

    // Fallback to 'English' if the stored language is not found in predefined languages
    if (storedLanguage != null && languages.any((lang) => lang['name'] == storedLanguage)) {
      selectedLanguage.value = storedLanguage;
      _updateLocale(storedLanguage);
    } else {
      // If no stored language or invalid, default to 'English'
      selectedLanguage.value = 'English';
      _updateLocale('English');
    }
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
    final box = GetStorage();
    box.write('language', language);
    _updateLocale(language);
  }

  void _updateLocale(String language) {
    try {
      // Check if the language exists in the list before updating locale
      String? localeCode = languages.firstWhere((lang) => lang['name'] == language)['locale'];
      if (localeCode != null) {
        var localeList = localeCode.split('_');
        Get.updateLocale(Locale(localeList[0], localeList[1]));
      }
    } catch (e) {
      print("Error updating locale: $e");
    }
  }
}
