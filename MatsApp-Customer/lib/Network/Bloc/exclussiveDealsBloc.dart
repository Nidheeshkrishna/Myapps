// import 'dart:async';


// import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
// import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';
// import 'package:matsapp/utilities/SharedPref.dart';


// enum ExclussiveDealsHomeBlocAction { fetch, load }

// class ExclussiveDealsHomeBloc {
//   //getStringFromSF();
//   var m;

//   //final Homepagedata;
//   //  final int increaseAge;

//   String apikey;

//   String town;
//   SharedPref sharedPref = SharedPref();
//   HomePageModel userSave = HomePageModel();
//   HomePageModel userLoad = HomePageModel();

//   final _exclusiveDealsController =
//       StreamController<List<DealsoftheDay>>.broadcast();

//   var news;
//   StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
//       _exclusiveDealsController.sink;
//   Stream<List<DealsoftheDay>> get exclusive_listStream =>
//       _exclusiveDealsController.stream;

//   // final _topstorestreamController2 = StreamController<List<List1>>.broadcast();
//   // StreamSink<List<List1>> get list2Sink => _topstorestreamController2.sink;
//   // Stream<List<List1>> get list2Stream2 => _topstorestreamController2.stream;

//   final _eventstreamController =
//       StreamController<ExclussiveDealsHomeBlocAction>();
//   StreamSink<ExclussiveDealsHomeBlocAction> get eventSink =>
//       _eventstreamController.sink;
//   Stream<ExclussiveDealsHomeBlocAction> get eventStream =>
//       _eventstreamController.stream;

//   // getdata() async {
//   //   GetCurrentLocation g = GetCurrentLocation();
//   //   apikey = await g.getApiKey;
//   //   town = await g.getSelectedTown();
//   //   //mobile = await g.getMobileNo();
//   // }

//   ExclussiveDealsHomeBloc() {
//     eventStream.listen((event) async {
//       if (event == ExclussiveDealsHomeBlocAction.fetch) {
//         try {
//           // loadSharedPrefs();
//           var news = await fetchHomeData();
//           if(news!=null){
            
//           }
        
//           if (news.exclusiveDeals.length > 0) {
//             exclusive_listSink.add(news.exclusiveDeals);

//             // list2Sink.add(news.list2);
//           } else {
//             exclusive_listSink.addError("Something went wrong");

//             // list2Sink.addError("Something went wrong");
//           }

//           if (news.exclusiveDeals.length > 0) {
//             exclusive_listSink.add(news.exclusiveDeals);
//             // list2Sink.add(news.list2);
//           } else {
//             exclusive_listSink.addError("Something went wrong");
//             // list2Sink.addError("Something went wrong");
//           }
//         } on Exception catch (_) {
//           exclusive_listSink.addError("Something went wrong");
//           exclusive_listSink.addError("Something went wrong");
//           // list2Sink.addError("Something went wrong");
//         }
//       } else {}
//     });
//   }

//   void dispose() {
//     _exclusiveDealsController.close();

//     //_topstorestreamController2.close();
//     _eventstreamController.close();
//   }

//   // loadSharedPrefs() async {
//   //   try {
//   //     HomePageModel user =
//   //         HomePageModel.fromJson(await sharedPref.read("user"));

//   //     news = user;
//   //   } catch (Excepetion) {
//   //     // do something
//   //   }
//   // }
// }
