import 'package:matsapp/Modeles/notifications/notifications_model.dart';

import 'package:matsapp/utilities/app_json_parser.dart';

import '../base_service.dart';

class NotificationsRepository extends BaseService {
  static NotificationsRepository _instance = NotificationsRepository._();

  NotificationsRepository._() : super();

  factory NotificationsRepository() {
    return _instance;
  }

  Future<void> getNotifications({
    onSuccess<List<NotificationsModel>> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();

    var params = {"UserID": userId};
    getService(
        service: "ViewNotifications",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<NotificationsModel> notifications =
              AppJsonParser.goodList(response, "result")
                  .map((e) => NotificationsModel.fromJson(e))
                  .toList();
          onSuccess(notifications);
        });
  }
}
