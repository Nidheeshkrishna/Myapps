import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/actions/notifications/notifications_action.dart';
import 'package:matsapp/redux/states/notifications/notificaiton_state.dart';

import 'package:redux/redux.dart';

import '../../models/loading_status.dart';

final notificationsReducer = combineReducers<NotificationsState>([
  TypedReducer<NotificationsState, LoadingAction>(_changeLoadingStatusAction),
  TypedReducer<NotificationsState, OnClearAction>(_clearAction),
  TypedReducer<NotificationsState, NotificationsFetchedAction>(
      _notificationsFetchedAction),
]);

NotificationsState _changeLoadingStatusAction(
    NotificationsState state, LoadingAction action) {
  return action.type == "Notifications"
      ? state.copyWith(
          loadingStatus: LoadingModel(
          loadingStatus: action.status,
          loadingMessage: action.message,
          loadingError: action.message,
          action: action.action,
          actionCallback: action.onAction,
        ))
      : state;
}

NotificationsState _clearAction(
    NotificationsState state, OnClearAction action) {
  if (action.type == "Notifications")
    return NotificationsState.initial();
  else
    return state;
}

NotificationsState _notificationsFetchedAction(
    NotificationsState state, NotificationsFetchedAction action) {
  return state.copyWith(
    notifications: action.notifications,
    loadingStatus: LoadingModel.success(),
  );
}
