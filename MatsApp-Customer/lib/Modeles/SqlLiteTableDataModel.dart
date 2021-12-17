class UserInfo {
  final int userid;
  final String mobilenumber;
  final String location;
  final String selectedTown;
  final String apitoken;
  final String islogeddIn;
  final String state;
  final String district;
  final String subtown;
  final String userType;

  UserInfo({
    this.userid,
    this.mobilenumber,
    this.location,
    this.selectedTown,
    this.apitoken,
    this.islogeddIn,
    this.state,
    this.district,
    this.subtown,
    this.userType,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'mobilenumber': mobilenumber,
      'location': location,
      "selected_town": selectedTown,
      "selected_state": state,
      "selected_district": district,
      "selected_subtown": subtown,
      'apitoken': apitoken,
      'islogeddIn': islogeddIn,
      'userType': userType,
    };
  }

  @override
  String toString() {
    return 'UserInfo{userid:$userid,mobilenumber: $mobilenumber,location:$location,selected_town:$selectedTown,selected_state:$state,selected_subtown:$subtown,selected_district:$district,apitoken: $apitoken, islogeddIn: $islogeddIn,userType:$userType}';
  }
}
