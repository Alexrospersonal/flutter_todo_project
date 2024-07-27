// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select time`
  String get timePickerTittle {
    return Intl.message(
      'Select time',
      name: 'timePickerTittle',
      desc: 'The title of the time picker dialog',
      args: [],
    );
  }

  /// `Select notification time`
  String get selectNotificationTime {
    return Intl.message(
      'Select notification time',
      name: 'selectNotificationTime',
      desc: 'Text for selecting a notification time',
      args: [],
    );
  }

  /// `English`
  String get langName {
    return Intl.message(
      'English',
      name: 'langName',
      desc: 'The name of the language',
      args: [],
    );
  }

  /// `En`
  String get shorLangName {
    return Intl.message(
      'En',
      name: 'shorLangName',
      desc: 'The short form of the language name',
      args: [],
    );
  }

  /// `+ 5m`
  String get timePickerTempale1 {
    return Intl.message(
      '+ 5m',
      name: 'timePickerTempale1',
      desc: 'Button label for adding 5 minutes',
      args: [],
    );
  }

  /// `+ 30m`
  String get timePickerTempale2 {
    return Intl.message(
      '+ 30m',
      name: 'timePickerTempale2',
      desc: 'Button label for adding 30 minutes',
      args: [],
    );
  }

  /// `+ 1h`
  String get timePickerTempale3 {
    return Intl.message(
      '+ 1h',
      name: 'timePickerTempale3',
      desc: 'Button label for adding 1 hour',
      args: [],
    );
  }

  /// `Daily progress`
  String get dailyProgress {
    return Intl.message(
      'Daily progress',
      name: 'dailyProgress',
      desc: 'Label for daily progress',
      args: [],
    );
  }

  /// `tasks`
  String get tasks {
    return Intl.message(
      'tasks',
      name: 'tasks',
      desc: 'Label for tasks',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: 'Label for today',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
