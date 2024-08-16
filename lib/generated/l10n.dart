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

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Oldest`
  String get oldest {
    return Intl.message(
      'Oldest',
      name: 'oldest',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Is coming`
  String get isComing {
    return Intl.message(
      'Is coming',
      name: 'isComing',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Important`
  String get important {
    return Intl.message(
      'Important',
      name: 'important',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `With files`
  String get withFiles {
    return Intl.message(
      'With files',
      name: 'withFiles',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Overdue`
  String get overdue {
    return Intl.message(
      'Overdue',
      name: 'overdue',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Month progress`
  String get monthProgress {
    return Intl.message(
      'Month progress',
      name: 'monthProgress',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Your status`
  String get yourStatus {
    return Intl.message(
      'Your status',
      name: 'yourStatus',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Easy and productive`
  String get statusTitle1 {
    return Intl.message(
      'Easy and productive',
      name: 'statusTitle1',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Determinated\ntasks:`
  String get determinatedTasks {
    return Intl.message(
      'Determinated\ntasks:',
      name: 'determinatedTasks',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Start in`
  String get startIn {
    return Intl.message(
      'Start in',
      name: 'startIn',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `d`
  String get shortDay {
    return Intl.message(
      'd',
      name: 'shortDay',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `h`
  String get shortHour {
    return Intl.message(
      'h',
      name: 'shortHour',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `m`
  String get shortMinute {
    return Intl.message(
      'm',
      name: 'shortMinute',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Remind`
  String get remind {
    return Intl.message(
      'Remind',
      name: 'remind',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `All week`
  String get week {
    return Intl.message(
      'All week',
      name: 'week',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Undo`
  String get cancel {
    return Intl.message(
      'Undo',
      name: 'cancel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Undo the last action`
  String get UndoLastAction {
    return Intl.message(
      'Undo the last action',
      name: 'UndoLastAction',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Create task`
  String get createTask {
    return Intl.message(
      'Create task',
      name: 'createTask',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Name`
  String get addTaskName {
    return Intl.message(
      'Name',
      name: 'addTaskName',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `New list`
  String get addNewList {
    return Intl.message(
      'New list',
      name: 'addNewList',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Additional settings`
  String get additionalSettingLabel {
    return Intl.message(
      'Additional settings',
      name: 'additionalSettingLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Date`
  String get additionalDateLabel {
    return Intl.message(
      'Date',
      name: 'additionalDateLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Time`
  String get additionalTimeLabel {
    return Intl.message(
      'Time',
      name: 'additionalTimeLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Duration`
  String get additionalDurationLabel {
    return Intl.message(
      'Duration',
      name: 'additionalDurationLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Notification`
  String get additionalNotificationLabel {
    return Intl.message(
      'Notification',
      name: 'additionalNotificationLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Repeat`
  String get additionalRepeatLabel {
    return Intl.message(
      'Repeat',
      name: 'additionalRepeatLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Info`
  String get additionalInfoLabel {
    return Intl.message(
      'Info',
      name: 'additionalInfoLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `CREATE`
  String get confirmVuttonLabel {
    return Intl.message(
      'CREATE',
      name: 'confirmVuttonLabel',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Repeat of days`
  String get repeatOfdays {
    return Intl.message(
      'Repeat of days',
      name: 'repeatOfdays',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Add last day of repeat`
  String get lastDayOfRepeat {
    return Intl.message(
      'Add last day of repeat',
      name: 'lastDayOfRepeat',
      desc: 'Label for newest filter',
      args: [],
    );
  }

  /// `Repeat in time`
  String get repeatInTime {
    return Intl.message(
      'Repeat in time',
      name: 'repeatInTime',
      desc: 'Label for newest filter',
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
