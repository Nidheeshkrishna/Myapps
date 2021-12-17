import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/DiscountForyouModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';

import 'package:matsapp/utilities/urls.dart';

Future<DiscountForyouModel> fetchDiscountforyou(
    [String town,
    String mobile,
    String apikey,
    String latitude,
    String longitude]) async {
  GetMylocation().getLocation();
  final http.Response response = await http.post(
    Uri.parse(Urls.discountsForYouUrl),
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
    // print("responseJson discounts 4 U: $responseJson");

    return DiscountForyouModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load storedeals Api');
  }
}

enum DiscountforyouAction { fetch, load }

class DiscountforyouBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _discountforyoustreamControllermain =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get mainSink =>
      _discountforyoustreamControllermain.sink;
  Stream<List<List1>> get mainStream =>
      _discountforyoustreamControllermain.stream;

  final _discountforyoustreamController1 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list1Sink =>
      _discountforyoustreamController1.sink;
  Stream<List<List1>> get list1Stream =>
      _discountforyoustreamController1.stream;

  final _discountforyoustreamController2 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list2Sink =>
      _discountforyoustreamController2.sink;
  Stream<List<List1>> get list2Stream2 =>
      _discountforyoustreamController2.stream;

  final _eventstreamController = StreamController<DiscountforyouAction>();
  StreamSink<DiscountforyouAction> get eventSink => _eventstreamController.sink;
  Stream<DiscountforyouAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  DiscountforyouBloc() {
    eventStream.listen((event) async {
      if (event == DiscountforyouAction.fetch) {
        try {
          var news = await fetchDiscountforyou();

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
    
    _discountforyoustreamControllermain.close();
    _discountforyoustreamController1.close();
    _discountforyoustreamController2.close();

    _eventstreamController.close();
  }
}
