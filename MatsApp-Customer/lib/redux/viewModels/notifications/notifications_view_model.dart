import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/notifications/notifications_model.dart';
import 'package:matsapp/redux/actions/notifications/notifications_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class NotificationsViewModel extends BaseViewModel {
  final VoidCallback getNotifications;
  final List<NotificationsModel> notifications;

  NotificationsViewModel({
    LoadingModel loadingStatus,
    this.getNotifications,
    this.notifications,
  }) : super(loadingStatus);

  factory NotificationsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.notificationsState;

    return NotificationsViewModel(
      loadingStatus: state.loadingStatus,
      notifications: state.notifications,
      getNotifications: () => store.dispatch(fetchNotificationsAction()),
    );
  }
}
