// import 'dart:async';

// import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
// import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

// enum DealsofTheDayHomeAction { fetch, load }

// class DealsofTheDayHomeBloc {
//   String apikey;

//   String town;

//   final _dealsofthedaytreamControllerResult =
//       StreamController<List<DealsoftheDay>>.broadcast();
//   StreamSink<List<DealsoftheDay>> get dealsoftheday_Sink =>
//       _dealsofthedaytreamControllerResult.sink;
//   Stream<List<DealsoftheDay>> get dealsoftheday_Stream =>
//       _dealsofthedaytreamControllerResult.stream;

//   // final _exclusiveDealsController =
//   //     StreamController<List<DealsoftheDay>>.broadcast();
//   // StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
//   //     _exclusiveDealsController.sink;
//   // Stream<List<DealsoftheDay>> get exclusive_listStream =>
//   //     _exclusiveDealsController.stream;

//   final _eventstreamController = StreamController<DealsofTheDayHomeAction>();
//   StreamSink<DealsofTheDayHomeAction> get eventSink =>
//       _eventstreamController.sink;
//   Stream<DealsofTheDayHomeAction> get eventStream =>
//       _eventstreamController.stream;

//   DealsofTheDayHomeBloc() {
//     eventStream.listen((event) async {
//       if (event == DealsofTheDayHomeAction.fetch) {
//         try {
//           var news = await fetchHomeData();

//           if (news.dealsoftheDay.length > 0) {
//             dealsoftheday_Sink.add(news.dealsoftheDay);
//           } else {
//             dealsoftheday_Sink.addError("Something went wrong");
//           }

//           // if (news.exclusiveDeals.length > 0) {
//           //   exclusive_listSink.add(news.exclusiveDeals);
//           // } else {
//           //   exclusive_listSink.addError("Something went wrong");
//           // }
//         } on Exception catch (_) {
//           dealsoftheday_Sink.addError("Something went wrong");
//           // exclusive_listSink.addError("Something went wrong");
//         }
//       } else {}
//     });
//   }

//   void dispose() {
//     _dealsofthedaytreamControllerResult.close();

//     _eventstreamController.close();
//   }
// }
