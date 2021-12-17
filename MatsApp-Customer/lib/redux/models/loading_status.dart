import 'package:flutter/cupertino.dart';

enum LoadingStatus { loading, error, success }

extension LoadingStatusExtensions on LoadingStatus {
  bool isLoading() => this == LoadingStatus.loading;

  bool hasError() => this == LoadingStatus.error;
}

class LoadingModel {
  LoadingStatus _loadingStatus;
  String _loadingError;
  String _loadingMessage;
  String _action;
  VoidCallback _actionCallback;

  LoadingModel({
    LoadingStatus loadingStatus,
    String loadingError,
    String loadingMessage,
    String action,
    VoidCallback actionCallback,
  })  : _loadingStatus = loadingStatus,
        _loadingError = loadingError,
        _loadingMessage = loadingMessage,
        _action = action,
        _actionCallback = actionCallback;

  LoadingModel.initial() {
    _loadingStatus = LoadingStatus.success;
    _loadingError = "";
    _loadingMessage = "";
    _action = "";
    _actionCallback = null;
  }

  LoadingModel.error({
    String message,
    String actionString,
    VoidCallback action,
  }) {
    _loadingStatus = LoadingStatus.error;
    _loadingError = message ?? "";
    _loadingMessage = "";
    _action = actionString ?? "";
    _actionCallback = action;
  }

  LoadingModel.loading({
    String message,
  }) {
    _loadingStatus = LoadingStatus.loading;
    _loadingMessage = message ?? "Loading";
    _loadingError = "";
    _action = "";
    _actionCallback = null;
  }

  LoadingModel.success({
    String message,
    String actionString,
    VoidCallback action,
  }) {
    _loadingStatus = LoadingStatus.success;
    _loadingError = "";
    _loadingMessage = "";
    _action = "";
    _actionCallback = null;
  }

  String get loadingError => _loadingError;

  String get loadingMessage => _loadingMessage;

  String get action => _action;

  VoidCallback get actionCallback => _actionCallback;

  bool get isLoading => _loadingStatus?.isLoading();

  bool get hasError => _loadingStatus?.hasError();
}
