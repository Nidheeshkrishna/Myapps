import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/find/find_category_model.dart';
import 'package:matsapp/redux/actions/find/find_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class FindViewModel extends BaseViewModel {
  final VoidCallback getCategories;
  final List<FindCategoryModel> categories;
  final String remarks;

  final String scannedImage;
  final ValueSetter<String> onFilePicked;
  final ValueSetter<String> onSave;
  final Function(FindCategoryModel, bool) onSelectCategory;

  final FindCategoryModel selectedCategory;
  final bool isEnquirySaved;

  FindViewModel({
    LoadingModel loadingStatus,
    this.getCategories,
    this.categories,
    this.onFilePicked,
    this.scannedImage,
    this.onSave,
    this.remarks,
    this.onSelectCategory,
    this.selectedCategory,
    this.isEnquirySaved,
  }) : super(loadingStatus);

  factory FindViewModel.fromStore(Store<AppState> store) {
    var state = store.state.findState;

    return FindViewModel(
      loadingStatus: state.loadingStatus,
      categories: state.categories,
      isEnquirySaved: state.isEnquirySaved,
      scannedImage: state.scannedImage,
      selectedCategory: state.selectedCategory,
      getCategories: () => store.dispatch(fetchFindCategoriesAction()),
      onSelectCategory: (category, isSelected) =>
          store.dispatch(SelectedFindCategoryAction(category, isSelected)),
      onFilePicked: (file) => store.dispatch(ScannedImageChangeAction(file)),
      onSave: (remarks) => store.dispatch(saveEnquiryAction(
          state.scannedImage, remarks, state.selectedCategory)),
    );
  }

  String validateSave(String remarks) {
    String validateMessage;
    if (selectedCategory == null)
      validateMessage = "Please select a category";
    else if (scannedImage?.isEmpty ?? true)
      validateMessage = "Please scan an Image";
    else
      onSave(remarks);
    return validateMessage;
  }
}
