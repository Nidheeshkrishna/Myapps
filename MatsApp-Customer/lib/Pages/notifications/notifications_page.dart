import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/notifications/notifications_model.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/notifications/notifications_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Notification", textAlign: TextAlign.center),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return StoreConnector<AppState, NotificationsViewModel>(
            converter: (store) => NotificationsViewModel.fromStore(store),
            onInitialBuild: (viewModel) => viewModel.getNotifications(),
            onWillChange: (old, viewModel) {
              if (old.isLoading && viewModel.hasError) {
                final snackBar =
                    SnackBar(content: Text(viewModel.loadingError ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            onDispose: (store) =>
                store.dispatch(OnClearAction(type: "Notifications")),
            builder: (context, viewModel) {
              return ListView.builder(
                  itemCount: viewModel.notifications?.length ?? 0,
                  itemBuilder: (context, position) {
                    var notification =
                        viewModel.notifications.elementAt(position);
                    return _NotificationItem(notification: notification);
                  });
            },
          );
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationsModel notification;

  const _NotificationItem({Key key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6)
            ]),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                  width: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.kPrimaryColor,
                  )),
              SizedBox(width: 10),
              SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(AppVectors.dolor_svg)),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${notification.tittle}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: const Color(0xff1d1d1d),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${notification.message}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: const Color(0xff1d1d1d),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Text(
                  notification.date,
                  // '${timeago.format(
                  //     // DateTime.now()
                  //     DateTime.parse(notification.createdDate))}',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 11,
                    color: const Color(0xff21a67a),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
