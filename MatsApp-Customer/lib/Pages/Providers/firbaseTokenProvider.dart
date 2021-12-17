import 'package:flutter/foundation.dart';

class FirbaseTokenProvider with ChangeNotifier {
  bool loading = false;

  String firebaseToken;
  getfirbaseToken(context, String firebaseToken) async {
    loading = true;
    firebaseToken = firebaseToken;
    loading = false;
    notifyListeners();
  }
}
