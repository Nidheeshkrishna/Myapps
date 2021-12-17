

import 'package:flutter/cupertino.dart';
import 'package:matsapp/redux/models/loading_status.dart';

extension LoadingStatusExtensions on LoadingStatus {
  bool isLoading() => this == LoadingStatus.loading;

  bool hasError() => this == LoadingStatus.error;
}

extension NumberExtension on num {
  bool get isGreaterThanZero => (this ?? 0) > 0;
}

extension MapExtensions on Map{

  void putIfValueNotNull({@required String key, dynamic value}) {
    if (key != null && value != null) putIfAbsent(key, () => value);
  }
}