import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/redux/actions/find/find_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class EnquiryViewModel extends BaseViewModel {
  final VoidCallback getEnquiries;

  final List<EnquiryModel> enquiries;

  EnquiryViewModel({
    LoadingModel loadingStatus,
    this.getEnquiries,
    this.enquiries,
  }) : super(loadingStatus);

  factory EnquiryViewModel.fromStore(Store<AppState> store) {
    var state = store.state.findState;

    return EnquiryViewModel(
      loadingStatus: state.enquiryLoadingStatus,
      enquiries: state.enquiries,
      getEnquiries: () => store.dispatch(fetchPreviousEnquiries()),
    );
  }
}
