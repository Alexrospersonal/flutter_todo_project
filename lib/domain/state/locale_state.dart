import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(super.state);
  
  void setLocale(Locale locale) {
    state = locale;
  }
}

final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));