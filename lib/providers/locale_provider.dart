import 'package:flutter/cupertino.dart';

class LocaledProvider extends ChangeNotifier{
  Locale _locale = const Locale('ar');

  Locale get getLocale => const Locale('en');

  void setLocale(Locale locale){
    _locale = locale;
    notifyListeners();
  }

  bool get isArabic{
    return _locale.languageCode == 'ar';
  }
}