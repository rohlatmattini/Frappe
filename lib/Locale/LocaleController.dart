import 'package:get/get.dart';

class MyLocale implements Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
  "ar":{
    "projects":"المشاريع",
    "Setting":"الإعدادات",
    "Dark mode":"الوضع الداكن",
    "Hi":"مرحباً",
    "first project":"المشروع الأول",
    "Term & Condition":"الشروط",
  },
    "en":{
      "projects":"project",
      "Setting":"Setting",
      "Dark mode":"Dark mode",
      "Hi":"Hi",
      "first project":"first project",
      "Term & Condition":"Term & Condition",
    }
    };
}