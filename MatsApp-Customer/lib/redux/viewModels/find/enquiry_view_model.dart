import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Modeles/find/find_stores_model.dart';
import 'package:matsapp/redux/actions/find/find_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class EnquiryDetailViewModel extends BaseViewModel {
  final List<FindStoresModel> stores;
  final Function(EnquiryModel) getFoundedStores;
  final Function(bool, FindStoresModel) onFavouriteChanged;

  EnquiryDetailViewModel({
    LoadingModel loadingStatus,
    this.getFoundedStores,
    this.stores,
    this.onFavouriteChanged,
  }) : super(loadingStatus);

  factory EnquiryDetailViewModel.fromStore(Store<AppState> store) {
    var state = store.state.findState;

    return EnquiryDetailViewModel(
        loadingStatus: state.enquiryDetailsLoadingStatus,
        stores: state.stores,
        getFoundedStores: (enquiry) =>
            store.dispatch(fetchLocalStores(enquiry: enquiry)),
        onFavouriteChanged: (wasFav, shop) =>
            store.dispatch(markStoreAsFavoriteAction(wasFav, shop)));
  }
}
