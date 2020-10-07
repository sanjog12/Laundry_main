

import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs{
	
	static setStringPreference(String key,String value)async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setString(key, value);
	}
	
	static getStringPreference(String key) async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.getString(key);
		return prefs.getString(key);
	}
	
	
	static removePreference(String key) async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.remove(key);
		return ;
	}
	
	static setListStringPreference(String key, List<String> value) async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setStringList(key, value);
		return ;
	}
	
	static getListStringPreference(String key) async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.getStringList(key);
		return prefs.getStringList(key);
	}
}