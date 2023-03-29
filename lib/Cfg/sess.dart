import 'package:shared_preferences/shared_preferences.dart';

class Sess{
 
    setSess(String key, String value ) async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.setString(key, value); 
    }

    Future<String?> getSess(String key) async {
      final prefs =  await SharedPreferences.getInstance(); 
      return prefs.getString(key);
    }

    remove(String key) async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.remove(key); 
    }

    destroy() async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.clear();
    }
    

}