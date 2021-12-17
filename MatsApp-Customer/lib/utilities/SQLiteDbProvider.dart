class SQLiteDbProvider {
  // final dbHelper = DatabaseHelper.instance;
  // // ignore: unused_element
  // Future insert(String username, String userTown) async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName: username,
  //     DatabaseHelper.columnTown: userTown
  //   };
  //   final id = await dbHelper.insert(row);
  //   print('inserted row id: $id');
  // }
  // DatabaseHelper con = new DatabaseHelper();

  // var db;
// //insertion
//   Future<int> saveUser(UserInfo user) async {
//     var dbClient = await con.db;
//     int res = await dbClient.insert("tbl_UserInfo", user.toMap());
//     return res;
//   }

//   //deletion
//   Future<int> deleteUser(UserInfo user) async {
//     var dbClient = await con.db;
//     int res = await dbClient.delete("tbl_UserInfo");
//     return res;
//   }

//   Future<UserInfo> getLogin(String user, String selectedTown) async {
//     var dbClient = await con.db;
//     var res = await dbClient.rawQuery(
//         "SELECT * FROM tbl_UserInfo WHERE username = '$user' and password = '$selectedTown'");

//     if (res.length > 0) {
//       return new UserInfo.fromMap(res.first);
//     }
//     return null;
//   }

//   Future<List<UserInfo>> getAllUser() async {
//     var dbClient = await con.db;
//     var res = await dbClient.query("tbl_UserInfo");

//     List<UserInfo> list =
//         res.isNotEmpty ? res.map((c) => UserInfo.fromMap(c)).toList() : null;
//     return list;
//   }
}
