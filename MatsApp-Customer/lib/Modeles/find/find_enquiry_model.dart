import 'package:matsapp/utilities/app_json_parser.dart';

class EnquiryModel {
  final int id;
  final String userDescription;
  final String imageURL;

  EnquiryModel._({
    this.id,
    this.userDescription,
    this.imageURL,
  });

  factory EnquiryModel.fromJson(Map<String, dynamic> json) {
    return EnquiryModel._(
      id: AppJsonParser.goodInt(json, 'ID'),
      userDescription: AppJsonParser.goodString(json, 'UserDescription'),
      imageURL: AppJsonParser.goodString(json, 'ImageURL'),
    );
  }
}
