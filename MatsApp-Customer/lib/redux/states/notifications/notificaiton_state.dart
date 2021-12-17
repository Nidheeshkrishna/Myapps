import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/notifications/notifications_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';

@immutable
class NotificationsState {
  final LoadingModel loadingStatus;
  final List<NotificationsModel> notifications;

  NotificationsState({
    this.loadingStatus,
    this.notifications,
  });

  NotificationsState copyWith({
    LoadingModel loadingStatus,
    List<NotificationsModel> notifications,
  }) {
    return NotificationsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      notifications: notifications ?? this.notifications,
    );
  }

  factory NotificationsState.initial() {
    return NotificationsState(
      loadingStatus: LoadingModel.initial(),
      notifications: [],
    );
  }
}
