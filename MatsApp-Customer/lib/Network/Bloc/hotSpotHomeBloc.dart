import 'dart:async';

import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

enum HotSpotHomeeAction { fetch, load }

class HotSpotHomeBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _topstorestreamControllerResult =
      StreamController<List<Hotspot>>.broadcast();
  StreamSink<List<Hotspot>> get hotspot_Sink =>
      _topstorestreamControllerResult.sink;
  Stream<List<Hotspot>> get hotspot_Stream =>
      _topstorestreamControllerResult.stream;

  // final _exclusiveDealsController =
  //     StreamController<List<DealsoftheDay>>.broadcast();
  // StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
  //     _exclusiveDealsController.sink;
  // Stream<List<DealsoftheDay>> get exclusive_listStream =>
  //     _exclusiveDealsController.stream;

  // final _topstorestreamController2 = StreamController<List<List1>>.broadcast();
  // StreamSink<List<List1>> get list2Sink => _topstorestreamController2.sink;
  // Stream<List<List1>> get list2Stream2 => _topstorestreamController2.stream;

  final _eventstreamController = StreamController<HotSpotHomeeAction>();
  StreamSink<HotSpotHomeeAction> get eventSink => _eventstreamController.sink;
  Stream<HotSpotHomeeAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  HotSpotHomeBloc() {
    eventStream.listen((event) async {
      if (event == HotSpotHomeeAction.fetch) {
        try {
          var news = await fetchHomeData();

          if (news.top9Store.length > 0) {
            hotspot_Sink.add(news.hotspot);

            // list2Sink.add(news.list2);
          } else {
            hotspot_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }

          // if (news.exclusiveDeals.length > 0) {
          //   exclusive_listSink.add(news.exclusiveDeals);
          //   // list2Sink.add(news.list2);
          // } else {
          //   exclusive_listSink.addError("Something went wrong");
          //   // list2Sink.addError("Something went wrong");
          // }
        } on Exception catch (_) {
          hotspot_Sink.addError("Something went wrong");
          //  exclusive_listSink.addError("Something went wrong");
          // list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    //  _exclusiveDealsController.close();
    _topstorestreamControllerResult.close();
   
    _eventstreamController.close();
  }
}
