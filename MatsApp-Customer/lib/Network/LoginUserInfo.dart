class LoginUserInfo {
  int userstatus;
  String usermobile;
  String userselectedtown;

  Future<int> get getuserStatus async => this.userstatus;

  set setstatus(int value) => this.userstatus = value;
  Future<String> get getuserMobile async => this.usermobile;

  set setuserName(String value) => this.usermobile = value;

  Future get getuserSelectedTown async => this.userselectedtown;

  set setuserTown(String value) => this.userselectedtown = value;
}
