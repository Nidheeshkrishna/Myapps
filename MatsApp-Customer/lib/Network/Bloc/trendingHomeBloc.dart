// import 'dart:async';

// import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
// import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

// enum TrendingHomeAction { fetch, load }

// class TrendingHomeBloc {
//   String apikey;

//   String town;

//   final _trendingOffersstreamControllerResult =
//       StreamController<List<TrendingOffer>>.broadcast();
//   StreamSink<List<TrendingOffer>> get trendingOffers_Sink =>
//       _trendingOffersstreamControllerResult.sink;
//   Stream<List<TrendingOffer>> get trendingOffers_Stream =>
//       _trendingOffersstreamControllerResult.stream;

//   // final _exclusiveDealsController =
//   //     StreamController<List<DealsoftheDay>>.broadcast();
//   // StreamSink<List<TrendingOffer>> get trendingOffers_Sink =>
//   //     _trendingOffersstreamControllerResult.sink;
//   // Stream<List<TrendingOffer>> get trendingOffers_Stream =>
//   //     _trendingOffersstreamControllerResult.stream;

//   final _eventstreamController = StreamController<TrendingHomeAction>();
//   StreamSink<TrendingHomeAction> get eventSink => _eventstreamController.sink;
//   Stream<TrendingHomeAction> get eventStream => _eventstreamController.stream;

//   TrendingHomeBloc() {
//     eventStream.listen((event) async {
//       if (event == TrendingHomeAction.fetch) {
//         try {
//           var news = await fetchHomeData();

//           if (news.trendingOffer.length > 0) {
//             trendingOffers_Sink.add(news.trendingOffer);
//           } else {
//             trendingOffers_Sink.addError("Something went wrong");
//           }
//         } on Exception catch (_) {
//           trendingOffers_Sink.addError("Something went wrong");
//         }
//       } else {}
//     });
//   }

//   void dispose() {
//     //_exclusiveDealsController.close();
//     _trendingOffersstreamControllerResult.close();

//     _eventstreamController.close();
//   }
// }
