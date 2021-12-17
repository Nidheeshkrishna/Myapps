import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Modeles/find/find_stores_model.dart';
import 'package:matsapp/Pages/_views/loading_mask.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/find/enquiry_view_model.dart';
import 'package:matsapp/utilities/app_extensions.dart';

class FindResultPage extends StatelessWidget {
  final EnquiryModel enquiry;

  const FindResultPage({Key key, this.enquiry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Find", textAlign: TextAlign.center),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return StoreConnector<AppState, EnquiryDetailViewModel>(
            converter: (store) => EnquiryDetailViewModel.fromStore(store),
            onInitialBuild: (viewModel) => viewModel.getFoundedStores(enquiry),
            onWillChange: (old, viewModel) {
              if (old.isLoading && viewModel.hasError) {
                final snackBar =
                    SnackBar(content: Text(viewModel.loadingError ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            onDispose: (store) =>
                store.dispatch(OnClearAction(type: "EnquiryDetail")),
            builder: (context, viewModel) {
              if (viewModel.isLoading) return AppLoadingMask();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${enquiry.userDescription}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: const Color(0xff1d1d1d),
                        letterSpacing: 0.32,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Container(
                        width: 149.3,
                        height: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(enquiry.imageURL),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Available Shops',
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 16,
                          color: const Color(0xff1d1d1d),
                          letterSpacing: 0.24,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.stores?.length ?? 0,
                          itemBuilder: (context, position) {
                            var store = viewModel.stores.elementAt(position);
                            return _AvailableStoreItem(
                              store: store,
                              onFavouriteChange: (wasFavorite) => viewModel
                                  .onFavouriteChanged(wasFavorite, store),
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AvailableStoreItem extends StatelessWidget {
  final FindStoresModel store;
  final Function(bool isFavourite) onFavouriteChange;

  const _AvailableStoreItem({
    Key key,
    this.store,
    this.onFavouriteChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: Container(
              width: 102,
              height: 102,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(store.imageUrl))),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(height: 4),
                Text(
                  '${store.businessName}',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: const Color(0xff1d1d1d),
                    letterSpacing: 0.451,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${store.rating}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: const Color(0xff1d1d1d),
                          letterSpacing: 0.451,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8),
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2),
                        onRatingUpdate: (double value) {},
                        initialRating: store.rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glow: true,
                        glowColor: AppColors.kPrimaryColor,
                        itemSize: 11,
                        itemBuilder: (BuildContext context, int index) {
                          return SvgPicture.asset(
                            AppVectors.favourite_svg,
                          );
                        },
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${store.reviewCount.isGreaterThanZero ? '(${store.reviewCount} reviews)' : ""}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: const Color(0xff707070),
                            letterSpacing: 0.18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: const Color(0xff1d1d1d),
                        letterSpacing: 0.18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: AppColors.kPrimaryColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${store.distanceKm} KM',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: const Color(0xff707070),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Builder(builder: (context) {
                  return Container(
                      height: 24,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: AppColors.kPrimaryColor),
                      child: Text('Visit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              color: const Color(0xffffffff),
                              letterSpacing: 0.78,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(color: Colors.white, blurRadius: 24)
                              ])));
                })
              ])),
          InkWell(
              onTap: () {
                onFavouriteChange(store.wishListId > 0);
              },
              child: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: store.wishListId > 0
                      ? Icon(
                          Icons.favorite_rounded,
                          color: AppColors.kPrimaryColor,
                        )
                      : Icon(Icons.favorite_border)))
        ])));
  }
}
