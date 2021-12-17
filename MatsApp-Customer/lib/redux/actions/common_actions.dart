import 'package:flutter/cupertino.dart';
import 'package:matsapp/redux/models/loading_status.dart';

class OnClearAction {
  final type;

  OnClearAction({this.type});
}

class LoadingAction {
  final type;
  final LoadingStatus status;
  final String message;
  final String action;
  final VoidCallback onAction;

  LoadingAction({
    @required this.status,
    @required this.message,
    this.action,
    this.onAction,
    this.type,
  });
}

class SetFilePathAction {
  final String filePath;

  SetFilePathAction({this.filePath});
}

class InitFilePathAction {
  final Function(String filePath) hasTokenCallback;

  InitFilePathAction({this.hasTokenCallback});
}
