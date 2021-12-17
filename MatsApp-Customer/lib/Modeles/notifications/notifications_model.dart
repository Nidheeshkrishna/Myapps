import 'package:matsapp/utilities/app_json_parser.dart';

class NotificationsModel {
  final int id;
  final int sender;
  final int receiver;
  final int postId;
  final String message;
  final String tittle;
  final String date;
  final int viewStatus;
  final String type;
  final String typeId;
  final int businessId;
  final int productId;
  final String notificationState;
  final String notificationDistrict;
  final String notificationTown;
  final String createdBy;
  final String createdDate;
  final String lastUpdatedBy;
  final String lastUpdatedDate;
  final String notificationStatus;

  NotificationsModel._({
    this.id,
    this.sender,
    this.receiver,
    this.postId,
    this.message,
    this.tittle,
    this.date,
    this.viewStatus,
    this.type,
    this.typeId,
    this.businessId,
    this.productId,
    this.notificationState,
    this.notificationDistrict,
    this.notificationTown,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.notificationStatus,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel._(
      id: AppJsonParser.goodInt(json, 'Notification_ID'),
      sender: AppJsonParser.goodInt(json, 'Notification_Sender'),
      receiver: AppJsonParser.goodInt(json, 'Notification_Reciever'),
      postId: AppJsonParser.goodInt(json, 'Notification_PostID'),
      message: AppJsonParser.goodString(json, 'Notification_Message'),
      tittle: AppJsonParser.goodString(json, 'Notification_MessageTittle'),
      date: AppJsonParser.goodString(json, 'Notification_Date'),
      viewStatus: AppJsonParser.goodInt(json, 'Notification_ViewStatus'),
      type: AppJsonParser.goodString(json, 'Notification_Type'),
      typeId: AppJsonParser.goodString(json, 'Notification_TypeID'),
      businessId: AppJsonParser.goodInt(json, 'Notification_BusinessID'),
      productId: AppJsonParser.goodInt(json, 'Notification_ProductID'),
      notificationState: AppJsonParser.goodString(json, 'Notification_State'),
      notificationDistrict:
          AppJsonParser.goodString(json, 'Notification_District'),
      notificationTown: AppJsonParser.goodString(json, 'Notification_Town'),
      createdBy: AppJsonParser.goodString(json, 'Notification_CreatedBy'),
      createdDate: AppJsonParser.goodString(json, 'Notification_CreatedDate'),
      lastUpdatedBy:
          AppJsonParser.goodString(json, 'Notification_LastUpdatedBy'),
      lastUpdatedDate:
          AppJsonParser.goodString(json, 'Notification_LastUpdatedDate'),
      notificationStatus: AppJsonParser.goodString(json, 'Notification_Status'),
    );
  }
}
