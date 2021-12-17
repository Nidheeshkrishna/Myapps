import 'package:matsapp/Modeles/notifications/notifications_model.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/services/notifications/notifications_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class NotificationsFetchedAction {
  final List<NotificationsModel> notifications;

  NotificationsFetchedAction(this.notifications);
}

ThunkAction fetchNotificationsAction() {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Coupons",
          type: "Notifications"));

      NotificationsRepository().getNotifications(onSuccess: (result) {
        store.dispatch(NotificationsFetchedAction(result));
      }, failure: (exception) {
        store.dispatch(LoadingAction(
          status: LoadingStatus.error,
          message: exception.toString(),
          type: "Notifications",
        ));
      });
    });
  };
}
