import 'package:shared_preferences/shared_preferences.dart';

class Helper {
// key for save in SP

  static String loggedKey = 'USERLOGGEDKEY';
  static String nameKey = 'USERNAMEKEY';
  static String emailKey = 'USEREMAILKEY';

// save the data

  static Future<bool?> setUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return await sharedPreferences.setBool(loggedKey, isUserLoggedIn);
    
  }

  static Future<bool?> setUserNameInStatus(String isUserName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString(nameKey, isUserName);
  }

  static Future<bool?> setUserEmailInStatus(String isUserEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return await sharedPreferences.setString(emailKey, isUserEmail);
  }

// get from SP

 static Future<bool?> getLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(loggedKey);
  }
  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(emailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(nameKey);
  }
}
