import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/actions/find/find_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/find/find_state.dart';
import 'package:redux/redux.dart';

import '../../models/loading_status.dart';

final findReducer = combineReducers<FindState>([
  TypedReducer<FindState, LoadingAction>(_changeLoadingStatusAction),
  TypedReducer<FindState, OnClearAction>(_clearAction),
  TypedReducer<FindState, ScannedImageChangeAction>(_scanAction),
  TypedReducer<FindState, SelectedFindCategoryAction>(_categoryChangeAction),
  TypedReducer<FindState, FindCategoriesFetchedAction>(
      _notificationsFetchedAction),
  TypedReducer<FindState, EnquiriesFetchedAction>(_enquiriesFetchedAction),
  TypedReducer<FindState, StoresFetchedAction>(_storesFetchedAction),
  TypedReducer<FindState, ShopMarkedFavouriteAction>(_favouriteAction),
  TypedReducer<FindState, EnquirySavedAction>(_enquirySavedAction),
]);

FindState _changeLoadingStatusAction(FindState state, LoadingAction action) {
  return action.type == "Find"
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

FindState _clearAction(FindState state, OnClearAction action) {
  if (action.type == "Find")
    return FindState.initial();
  else
    return state;
}

FindState _notificationsFetchedAction(
    FindState state, FindCategoriesFetchedAction action) {
  return state.copyWith(
    categories: action.categories,
    loadingStatus: LoadingModel.success(),
  );
}

FindState _enquiriesFetchedAction(
    FindState state, EnquiriesFetchedAction action) {
  return state.copyWith(
    enquiryLoadingStatus: LoadingModel.success(),
    enquiries: action.enquiries,
  );
}

FindState _storesFetchedAction(FindState state, StoresFetchedAction action) {
  return state.copyWith(
    enquiryDetailsLoadingStatus: LoadingModel.success(),
    stores: action.stores,
    selectedEnquiry: action.enquiry,
  );
}

FindState _scanAction(FindState state, ScannedImageChangeAction action) {
  return state.copyWith(
    scannedImage: action.file,
    isEnquirySaved: false,
  );
}

FindState _categoryChangeAction(
    FindState state, SelectedFindCategoryAction action) {
  return state.copyWith(
    selectedCategory: action.isSelected ? action.category : null,
    isCategoryChanged: true,
  );
}

FindState _favouriteAction(FindState state, ShopMarkedFavouriteAction action) {
  return state.copyWith(
    stores: state.stores.map((e) {
      if (e.businessId == action.shop.businessId) {
        e = e.copyWith(
          wishListId: action.wasFav ? 0 : 15,
          // wishListId: action.wasFav ? 0 : int.parse(action.result.result),
        );
        print(
            "reducer : changing fav for ${e.businessName} ${action.wasFav} ${e.wishListId} ");

        return e;
      } else {
        return e;
      }
    }).toList(),
    enquiryDetailsLoadingStatus: LoadingModel.success(),
  );
}

FindState _enquirySavedAction(FindState state, EnquirySavedAction action) {
  return state.copyWith(
      isEnquirySaved: true, enquiryLoadingStatus: LoadingModel.success());
}
