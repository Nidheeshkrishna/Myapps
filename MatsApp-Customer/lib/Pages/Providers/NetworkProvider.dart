import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/Login/LoginExistCheckModel.dart';
import 'package:matsapp/Network/LoginExistCheckRepo.dart';

class SessionProvider with ChangeNotifier {
  bool loading = false;
  LoginExistCheckModel loginExistCheckModel = LoginExistCheckModel();
  bool status;
  getSessionexpired(
    context,
    bool loginstatus,
  ) async {
    loading = true;
    loginExistCheckModel = await loginExistCheck();
    loading = false;

    notifyListeners();
  }
}


