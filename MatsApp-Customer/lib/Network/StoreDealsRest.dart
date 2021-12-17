import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:matsapp/Modeles/StoreDealsModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';
import 'package:matsapp/utilities/urls.dart';

Future<StoreDealsModel> fetchStoreDeals(
    [String town,
    String mobile,
    String apikey,
    String latitude,
    String longitude]) async {
  //GetCurrentLocation().getCurrentLocation();
  GetMylocation().getLocation();

  final http.Response response = await http.post(
    Uri.parse(Urls.trendingoffers),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Town': await userData().getSelectedTown(),
      'mobile': await userData().getMobileNo(),
      'api_Key': await userData().getApiKey,
      'Latitude': await userData().getMyLatitude,
      'Longitude': await userData().getMyLogitude
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson stores: $responseJson");

    return StoreDealsModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load storedeals Api');
  }
}

enum TrendingOffersAction { fetch, load }

class TrendingOffersBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _trendingOffersstreamControllermain =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get mainSink =>
      _trendingOffersstreamControllermain.sink;
  Stream<List<List1>> get mainStream =>
      _trendingOffersstreamControllermain.stream;

  final _trendingOffersstreamController1 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list1Sink =>
      _trendingOffersstreamController1.sink;
  Stream<List<List1>> get list1Stream =>
      _trendingOffersstreamController1.stream;

  final _trendingOffersstreamController2 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list2Sink =>
      _trendingOffersstreamController2.sink;
  Stream<List<List1>> get list2Stream2 =>
      _trendingOffersstreamController2.stream;

  final _eventstreamController = StreamController<TrendingOffersAction>();
  StreamSink<TrendingOffersAction> get eventSink => _eventstreamController.sink;
  Stream<TrendingOffersAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  TrendingOffersBloc() {
    eventStream.listen((event) async {
      if (event == TrendingOffersAction.fetch) {
        try {
          var news = await fetchStoreDeals();

          if (news.apiKeyStatus) {
            mainSink.add(news.result);
            list1Sink.add(news.list1);
            list2Sink.add(news.list2);
          } else {
            mainSink.addError("Something went wrong");
            list1Sink.addError("Something went wrong");
            list2Sink.addError("Something went wrong");
          }
        } on Exception catch (_) {
          mainSink.addError("Something went wrong");
          list1Sink.addError("Something went wrong");
          list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    _trendingOffersstreamControllermain.close();
    _trendingOffersstreamController1.close();
    _trendingOffersstreamController2.close();

    _eventstreamController.close();
  }
}
