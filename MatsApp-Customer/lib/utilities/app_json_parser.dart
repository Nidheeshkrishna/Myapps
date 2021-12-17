class AppJsonParser {
  static int goodHexInt(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null
          ? int.parse(json[key].toString().replaceAll('#', '0x'))
          : null;
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return null;
  }

  static String goodString(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null
          ? json[key].toString()
          : null;
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return null;
  }

  static double goodDouble(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null
          ? double.parse(json[key].toString())
          : null;
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return null;
  }

  static int goodInt(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null
          ? int.parse(json[key].toString())
          : null;
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return null;
  }

  static List goodList(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null && json[key] is List
          ? json[key] as List
          : [];
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return [];
  }

  static bool goodBoolean(Map<String, dynamic> json, String key) {
    try {
      return json.containsKey(key) && json[key] != null && json[key] is bool
          ? json[key] as bool
          : false;
    } catch (e) {
      print("error in parser $key : ${e.toString()}");
    }
    return false;
  }
}
