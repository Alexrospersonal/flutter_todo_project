import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

enum SnackBarMessageType { noEnabledDate, noEnabledTime, noEnabledRepeatedly }

class DialogSnackBarController {
  static final _instance = DialogSnackBarController._internal();
  DialogSnackBarController._internal();

  factory DialogSnackBarController() {
    return _instance;
  }

  void callSnackBar(
      BuildContext dialogContext, SnackBarMessageType messageType) {
    final String message = getMessageType(messageType, dialogContext);

    var snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(dialogContext).showSnackBar(snackBar);
  }

  String getMessageType(SnackBarMessageType messageType, BuildContext context) {
    switch (messageType) {
      case SnackBarMessageType.noEnabledDate:
        return S.of(context).snackInfoMessageDate;
      case SnackBarMessageType.noEnabledTime:
        return S.of(context).snackInfoMessageTime;
      case SnackBarMessageType.noEnabledRepeatedly:
        return S.of(context).snackInfoMessageRepeatedly;
    }
  }
}

void Function(SnackBarMessageType) getCallInformBar(BuildContext context) {
  return (SnackBarMessageType messageType) {
    DialogSnackBarController().callSnackBar(context, messageType);
  };
}
