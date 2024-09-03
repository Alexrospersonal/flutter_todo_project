import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

enum SnackBarMessageType { noEnabledDate, noEnabledTime, noEnabledRepeatedly, noValidateTitle }

class DialogSnackBarController {
  static final _instance = DialogSnackBarController._internal();
  DialogSnackBarController._internal();

  factory DialogSnackBarController() {
    return _instance;
  }

  void callSnackBar(BuildContext context, SnackBarMessageType messageType) {
    final String message = getMessageType(messageType, context);

    var snackBar = SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Theme.of(context).canvasColor,
        backgroundColor: Theme.of(context).colorScheme.error);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getMessageType(SnackBarMessageType messageType, BuildContext context) {
    switch (messageType) {
      case SnackBarMessageType.noEnabledDate:
        return S.of(context).snackInfoMessageDate;
      case SnackBarMessageType.noEnabledTime:
        return S.of(context).snackInfoMessageTime;
      case SnackBarMessageType.noEnabledRepeatedly:
        return S.of(context).snackInfoMessageRepeatedly;
      case SnackBarMessageType.noValidateTitle:
        return S.of(context).snackInfoMessageTitleIsEmpty;
    }
  }
}

void Function(SnackBarMessageType) getCallInformBar(BuildContext context) {
  return (SnackBarMessageType messageType) {
    DialogSnackBarController().callSnackBar(context, messageType);
  };
}
