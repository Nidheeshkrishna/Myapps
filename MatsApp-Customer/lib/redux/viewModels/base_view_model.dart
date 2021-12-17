import 'package:matsapp/redux/models/loading_status.dart';

abstract class BaseViewModel {
  final LoadingModel loadingStatus;

  BaseViewModel(this.loadingStatus);

  bool get isLoading => loadingStatus.isLoading;

  bool get hasError => loadingStatus.hasError;

  String get loadingMessage => loadingStatus.loadingMessage;

  String get loadingError => loadingStatus.loadingError;
}
