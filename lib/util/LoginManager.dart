import 'dart:convert';

import 'package:dixapp/models/BackupResult.dart';
import 'package:dixapp/models/ContactResult.dart';
import 'package:dixapp/models/Session.dart';
import 'package:dixapp/util/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginManager{

  static Future signIn(Session session)async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.deleteAllRegistrationData();
      print("All Login deleted");
    await databaseHelper.insertRegistrationData({
        "data":session.toJsonString()
      });

  }

  static Future signOut()async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.deleteAllRegistrationData();

  }

  static Future<Session> connectedUser()async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> result = await databaseHelper.getDataMapList();

    if(result != null && result.isNotEmpty){
      var loginData = result.first;
      if(loginData != null){

        String profileJson= loginData["data"];
        //print("List Result $profileJson");
        if(profileJson !=null && profileJson.isNotEmpty){
          Map<String, dynamic> profileMap = jsonDecode(profileJson);

          var profile = Session.fromJson(profileMap);
          //print("Profile found $profile");
          if(profile != null){
            return profile;
          }  else{
            return null;
          }
        }  else{
          return null;
        }

      }  else{
        return null;
      }
    }  else{
      return null;
    }
  }

  static Future<ContactResult> findContacts()async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> result = await databaseHelper.getQueryMapList();

    if(result != null && result.isNotEmpty){
      var loginData = result.first;
      if(loginData != null){

        String profileJson= loginData["data"];
        //print("List Result $profileJson");
        if(profileJson !=null && profileJson.isNotEmpty){
          Map<String, dynamic> profileMap = jsonDecode(profileJson);

          var profile = ContactResult.fromJson(profileMap);
          //print("Profile found $profile");
          if(profile != null){
            return profile;
          }  else{
            return null;
          }
        }  else{
          return null;
        }

      }  else{
        return null;
      }
    }  else{
      return null;
    }
  }

  static Future saveContacts(ContactResult contactResult)async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.deleteAllQueryData();
    print("All Contacts deleted");
    await databaseHelper.insertQueryData({
      "data":contactResult.toJsonString()
    });

  }

  static Future saveContactsBackup(BackupResult backupResult)async{

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> BACKUUUUUUUUUUUUUUUUUUUUUUUUUUUUUP <<<<<<<<<<<<<<<<<<<<<<<<<");
    DatabaseHelper databaseHelper = DatabaseHelper();

    await databaseHelper.deleteAllBackup();
    print("Backup deleted");
    await databaseHelper.insertBackup({
      "data":backupResult.toJsonString()
    });

  }

  static Future storeBackup(BackupResult backupResult)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool("IS_FIRST_TIME");

    if(isFirstTime == null || !isFirstTime){

      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FIRST_TIME <<<<<<<<<<<<<<<<<<<<<<<<<");

      await saveContactsBackup(backupResult);

      prefs.setBool("IS_FIRST_TIME",true);

    }

  }


  static Future<BackupResult> loadBackupContacts()async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> result = await databaseHelper.getBackupMapList();

    if(result != null && result.isNotEmpty){
      var loginData = result.first;
      if(loginData != null){

        String profileJson= loginData["data"];
        print("List Result $profileJson");
        if(profileJson !=null && profileJson.isNotEmpty){
          Map<String, dynamic> profileMap = jsonDecode(profileJson);

          var profile = BackupResult.fromJson(profileMap);
          //print("Profile found $profile");
          if(profile != null){
            return profile;
          }  else{
            return null;
          }
        }  else{
          return null;
        }

      }  else{
        return null;
      }
    }  else{
      return null;
    }
  }
}