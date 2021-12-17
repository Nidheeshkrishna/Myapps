import 'package:matsapp/utilities/app_json_parser.dart';

class FindCategoryModel {
  final int id;
  final String categoryName;
  final String categoryImage;
  final bool categoryFind;

  FindCategoryModel._({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.categoryFind,
  });

  factory FindCategoryModel.fromJson(Map<String, dynamic> json) {
    return FindCategoryModel._(
      id: AppJsonParser.goodInt(json, 'Id'),
      categoryName: AppJsonParser.goodString(json, 'CategoryName'),
      categoryImage: AppJsonParser.goodString(json, 'CategoryImage'),
      categoryFind: AppJsonParser.goodBoolean(json, 'CategoryFind'),
    );
  }
}
