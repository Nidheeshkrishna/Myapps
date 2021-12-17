import 'dart:async';
import 'dart:convert';

import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';
import 'package:matsapp/utilities/HomePageData.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TopStoreHomeAction { fetch, load }

class TopstoreHomeBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _topstorestreamControllerResult =
      StreamController<List<Top9Store>>.broadcast();

  var news;
  StreamSink<List<Top9Store>> get topstore_Sink =>
      _topstorestreamControllerResult.sink;
  Stream<List<Top9Store>> get topstore_Stream =>
      _topstorestreamControllerResult.stream;

  final _exclusiveDealsController =
      StreamController<List<DealsoftheDay>>.broadcast();
  StreamSink<List<DealsoftheDay>> get exclusive_listSink =>
      _exclusiveDealsController.sink;
  Stream<List<DealsoftheDay>> get exclusive_listStream =>
      _exclusiveDealsController.stream;

  // final _topstorestreamController2 = StreamController<List<List1>>.broadcast();
  // StreamSink<List<List1>> get list2Sink => _topstorestreamController2.sink;
  // Stream<List<List1>> get list2Stream2 => _topstorestreamController2.stream;

  final _eventstreamController = StreamController<TopStoreHomeAction>();
  StreamSink<TopStoreHomeAction> get eventSink => _eventstreamController.sink;
  Stream<TopStoreHomeAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  TopstoreHomeBloc() {
    eventStream.listen((event) async {
      if (event == TopStoreHomeAction.fetch) {
        try {
          news = await fetchHomeData();
          userData.homedata = news;
          addStringToSF();
          //getStringFromSF();
          HomePageData(news);
          // hr = new HomePageData(homeData);
          var resp = HomePageData().gethomePageData;
          print("datass&&&&&&&&&&&&&& $resp.");

          if (news.top9Store.length > 0) {
            topstore_Sink.add(news.top9Store);

            // list2Sink.add(news.list2);
          } else {
            topstore_Sink.addError("Something went wrong");

            // list2Sink.addError("Something went wrong");
          }

          if (news.exclusiveDeals.length > 0) {
            exclusive_listSink.add(news.exclusiveDeals);
            // list2Sink.add(news.list2);
          } else {
            exclusive_listSink.addError("Something went wrong");
            // list2Sink.addError("Something went wrong");
          }
        } on Exception catch (_) {
          topstore_Sink.addError("Something went wrong");
          exclusive_listSink.addError("Something went wrong");
          // list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    exclusive_listSink.close();

    //_topstorestreamController2.close();
    _eventstreamController.close();
    _exclusiveDealsController.close();
    _topstorestreamControllerResult.close();
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('key', json.encode(news));
  }

  // getStringFromSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Map<String, dynamic> map = json.decode(prefs.getString('key'));
  //   var m = json.decode(prefs.getString('key'));
  //   print("dataaas565666666666666666666666666666$m");
  // }
}
