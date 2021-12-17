import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/find/find_category_model.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Modeles/find/find_stores_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';

@immutable
class FindState {
  final LoadingModel loadingStatus;
  final LoadingModel enquiryLoadingStatus;
  final LoadingModel enquiryDetailsLoadingStatus;
  final List<FindCategoryModel> categories;

  final List<EnquiryModel> enquiries;
  final List<FindStoresModel> stores;
  final EnquiryModel selectedEnquiry;
  final String scannedImage;
  final FindCategoryModel selectedCategory;
  final bool isEnquirySaved;

  FindState({
    this.loadingStatus,
    this.enquiryLoadingStatus,
    this.categories,
    this.enquiries,
    this.stores,
    this.enquiryDetailsLoadingStatus,
    this.scannedImage,
    this.selectedCategory,
    this.selectedEnquiry,
    this.isEnquirySaved,
  });

  FindState copyWith({
    LoadingModel loadingStatus,
    LoadingModel enquiryDetailsLoadingStatus,
    LoadingModel enquiryLoadingStatus,
    List<FindCategoryModel> categories,
    List<EnquiryModel> enquiries,
    List<FindStoresModel> stores,
    String scannedImage,
    bool isCategoryChanged = false,
    FindCategoryModel selectedCategory,
    EnquiryModel selectedEnquiry,
    bool isEnquirySaved,
  }) {
    return FindState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      enquiryLoadingStatus: enquiryLoadingStatus ?? this.enquiryLoadingStatus,
      categories: categories ?? this.categories,
      enquiries: enquiries ?? this.enquiries,
      stores: stores ?? this.stores,
      enquiryDetailsLoadingStatus:
          enquiryDetailsLoadingStatus ?? this.enquiryDetailsLoadingStatus,
      scannedImage: scannedImage ?? this.scannedImage,
      selectedEnquiry: selectedEnquiry ?? this.selectedEnquiry,
      isEnquirySaved: isEnquirySaved ?? this.isEnquirySaved,
      selectedCategory: isCategoryChanged
          ? selectedCategory
          : selectedCategory ?? this.selectedCategory,
    );
  }

  factory FindState.initial() {
    return FindState(
      loadingStatus: LoadingModel.initial(),
      enquiryLoadingStatus: LoadingModel.initial(),
      enquiryDetailsLoadingStatus: LoadingModel.initial(),
      scannedImage: null,
      categories: [],
      stores: [],
      enquiries: [],
      selectedCategory: null,
      selectedEnquiry: null,
      isEnquirySaved: false,
    );
  }
}
