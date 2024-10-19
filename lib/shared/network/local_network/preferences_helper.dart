import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceHelper
{
  static SharedPreferences? prefs;
  static init()async
  {
     try{
       prefs = await SharedPreferences.getInstance();
       print("Preferences initialized successfully");
     }
     catch(e){
       print("Failed to get preferences: $e");
     }
  }

 // is OnBoarding Seen

  static Future<bool> isOnBoardingSeen({required bool isOnBoardingSeen})async{
    return await prefs?.setBool("isOnBoardingSeen", isOnBoardingSeen) ?? false;
  }
  static Future<bool> get getIsOnBoardingSeen async{
   return prefs?.getBool("isOnBoardingSeen")?? false;
  }



}