// import 'dart:async';

// import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
// import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

// enum DiscountsHomeAction { fetch, load }

// class DiscountsForYouHomeBloc {
//   String apikey;

//   String town;

//   final _discountshomestreamControllerResult =
//       StreamController<List<DealsoftheDay>>.broadcast();
//   StreamSink<List<DealsoftheDay>> get discounts_Sink =>
//       _discountshomestreamControllerResult.sink;
//   Stream<List<DealsoftheDay>> get discounts_Stream =>
//       _discountshomestreamControllerResult.stream;

//   // final _exclusiveDealsController =
//   //     StreamController<List<DealsoftheDay>>.broadcast();
//   // StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
//   //     _exclusiveDealsController.sink;
//   // Stream<List<DealsoftheDay>> get exclusive_listStream =>
//   //     _exclusiveDealsController.stream;

//   final _eventstreamController = StreamController<DiscountsHomeAction>();
//   StreamSink<DiscountsHomeAction> get eventSink => _eventstreamController.sink;
//   Stream<DiscountsHomeAction> get eventStream => _eventstreamController.stream;

//   DiscountsForYouHomeBloc() {
//     eventStream.listen((event) async {
//       if (event == DiscountsHomeAction.fetch) {
//         try {
//           var news = await fetchHomeData();
//           if (news != null) {
//             if (news.discountForyou.length > 0) {
//               discounts_Sink.add(news.discountForyou);
//             } else {
//               discounts_Sink.addError("Something went wrong");
//             }
//           }

//           // if (news.exclusiveDeals.length > 0) {
//           //   exclusive_listSink.add(news.exclusiveDeals);
//           // } else {
//           //   exclusive_listSink.addError("Something went wrong");
//           // }
//         } on Exception catch (_) {
//           discounts_Sink.addError("Something went wrong");
//           //exclusive_listSink.addError("Something went wrong");
//         }
//       } else {}
//     });
//   }

//   void dispose() {
//     // _exclusiveDealsController.close();
//     _discountshomestreamControllerResult.close();

//     _eventstreamController.close();
//   }
// }
