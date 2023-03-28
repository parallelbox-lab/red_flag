import 'package:shared_preferences/shared_preferences.dart';

class UserData{

  static SharedPreferences? _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String? getUserEmail() {
    return _sharedPreferences?.getString('userEmail');
  }
  static String? getUserProfilePic() {
    return _sharedPreferences?.getString('profilePicture');
  }

  static bool? getPremium() {
    return _sharedPreferences?.getBool('isPremium');
  }

  static String? getUserId() {
    return _sharedPreferences?.getString('userId');
  }
  static String? authType() {
   return _sharedPreferences?.getString('authType');
  }
  static String? fullName() {
   return _sharedPreferences?.getString('fullName');
  }

  static String? userRole(){
    return _sharedPreferences?.getString('userRole');
  }
 
 static updatePremiumStatus(bool isPremium) async {
    await _sharedPreferences?.setBool('isPremium', isPremium);
  }
 
}