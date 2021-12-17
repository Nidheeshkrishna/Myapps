import 'dart:async';

import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

enum HomeAdsBlocAction { fetch, load }

class HomeAdsBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _homead1 = StreamController<List<Banners>>();
 // ignore: non_constant_identifier_names
  StreamSink<List<Banners>> get homead1_Sink => _homead1.sink;
  // ignore: non_constant_identifier_names
  Stream<List<Banners>> get homead1_Stream => _homead1.stream;

  final _homead2 = StreamController<List<Banners>>.broadcast();
  // ignore: non_constant_identifier_names
  StreamSink<List<Banners>> get homead2_Sink => _homead2.sink;
 // ignore: non_constant_identifier_names
  Stream<List<Banners>> get homead2_Stream => _homead2.stream;

  final _homead3 = StreamController<List<Banners>>.broadcast();
  // ignore: non_constant_identifier_names
  StreamSink<List<Banners>> get homead3_Sink => _homead3.sink;
  // ignore: non_constant_identifier_names
  Stream<List<Banners>> get homead3_Stream => _homead3.stream;

  final _homead4 = StreamController<List<Banners>>.broadcast();
  // ignore: non_constant_identifier_names
  StreamSink<List<Banners>> get homead4_Sink => _homead4.sink;
 // ignore: non_constant_identifier_names
  Stream<List<Banners>> get homead4_Stream => _homead4.stream;

  // final _exclusiveDealsController =
  //     StreamController<List<DealsoftheDay>>.broadcast();
  // StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
  //     _exclusiveDealsController.sink;
  // Stream<List<DealsoftheDay>> get exclusive_listStream =>
  //     _exclusiveDealsController.stream;

  // final _topstorestreamController2 = StreamController<List<List1>>.broadcast();
  // StreamSink<List<List1>> get list2Sink => _topstorestreamController2.sink;
  // Stream<List<List1>> get list2Stream2 => _topstorestreamController2.stream;

  final _eventstreamController = StreamController<HomeAdsBlocAction>();
  StreamSink<HomeAdsBlocAction> get eventSink => _eventstreamController.sink;
  Stream<HomeAdsBlocAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  HomeAdsBloc() {
    eventStream.listen((event) async {
      if (event == HomeAdsBlocAction.fetch) {
        try {
          var news = await fetchHomeData();

          if (news.banners1.length != null) {
            homead1_Sink.add(news.banners1);

            // list2Sink.add(news.list2);
          } else {
            homead1_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }

          if (news.banners2.length != null) {
            homead2_Sink.add(news.banners2);

            // list2Sink.add(news.list2);
          } else {
            homead2_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }

          if (news.banners3.length != null) {
            homead3_Sink.add(news.banners3);

            // list2Sink.add(news.list2);
          } else {
            homead3_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }

          if (news.banners4.length != null) {
            homead4_Sink.add(news.banners4);

            // list2Sink.add(news.list2);
          } else {
            homead4_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }
        } on Exception catch (_) {
          // homead1_Sink.addError("Something went wrong");
          // homead2_Sink.addError("Something went wrong");
          // homead3_Sink.addError("Something went wrong");
          // homead4_Sink.addError("Something went wrong");
          //  exclusive_listSink.addError("Something went wrong");
          // list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    //  _exclusiveDealsController.close();

    _homead1.close();
    _homead2.close();
    _homead3.close();
    _homead4.close();

    //_topstorestreamController2.close();

    _eventstreamController.close();
  }
}
