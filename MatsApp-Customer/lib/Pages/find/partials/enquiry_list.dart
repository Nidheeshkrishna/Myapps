import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Pages/find/find_result_page.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/find/previous_enquiry_view_model.dart';

class PreviousEnquiriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EnquiryViewModel>(
        converter: (store) => EnquiryViewModel.fromStore(store),
        onInitialBuild: (viewModel) => viewModel.getEnquiries(),
        onWillChange: (old, viewModel) {
          if (old.isLoading && viewModel.hasError) {
            final snackBar =
                SnackBar(content: Text(viewModel.loadingError ?? ""));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        onDispose: (store) => store.dispatch(OnClearAction(type: "Enquiry")),
        builder: (context, viewModel) {
          return RefreshIndicator(
            onRefresh: () =>
                Future.delayed(kThemeAnimationDuration, viewModel.getEnquiries),
            child: ListView.builder(
                itemCount: viewModel.enquiries?.length ?? 0,
                itemBuilder: (context, position) {
                  var enquiry = viewModel.enquiries.elementAt(position);
                  return TextButton(
                    child: _EnquiryListItem(enquiry: enquiry),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FindResultPage(enquiry: enquiry);
                      }));
                    },
                  );
                }),
          );
        });
  }
}

class _EnquiryListItem extends StatelessWidget {
  final EnquiryModel enquiry;

  const _EnquiryListItem({Key key, this.enquiry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 119.0,
            height: 129.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  bottomLeft: Radius.circular(14.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(enquiry.imageURL),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ]),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${enquiry.userDescription ?? ""}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: const Color(0xff1d1d1d),
                  letterSpacing: 0.22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 12),
              Container(
                  width: 76,
                  alignment: Alignment.center,
                  height: 33,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: const Color(0xffff4646),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x82ff4646),
                        offset: Offset(0, 7),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Text('View',
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xffffffff),
                          letterSpacing: 0.496,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left))
            ],
          ))
        ],
      ),
    );
  }
}
