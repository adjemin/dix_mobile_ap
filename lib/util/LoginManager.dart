/***import 'dart:convert';

import 'package:dixapp/authentication/authentication.dart';
import 'package:dixapp/rest/Session.dart';
import 'package:dixapp/util/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginManager{

  static void signIn(Session s, Function onSuccess, Function onError){

    Session _session = s;

    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.deleteAllRegistrationData().then((int res){
      print("All Login deleted");
      databaseHelper.insertRegistrationData({
        "data":_session.toJsonString()
      })
          .then((int result){
        print("Login saved");
        onSuccess(_session);
      }).catchError((error){
        print("Error found $error");
        onError(error);
      });

    }).catchError((e){

      print("Deletion Error found $e");
      onError(e);

    });
  }

  static void signOutNow(BuildContext context){
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationLoggedOut());
  }

  static void connectedUser(Function onSuccess, Function onError){
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.getDataMapList()
        .then((List<Map<String, dynamic>> result){

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
                      onSuccess(profile);
                    }else{
                      onError(Exception("profile not found"));
                    }
                }else{
                  onError(Exception("profile not found"));
                }

              }
            }
    }).catchError((error){
      print("Error found $error");
      onError(error);
    });
  }

  static Future<Session> connected()async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> result = await databaseHelper.getDataMapList();

    if(result != null && result.isNotEmpty){
      var loginData = result.first;
      if(loginData != null){

        String profileJson= loginData["data"];

        if(profileJson !=null && profileJson.isNotEmpty){
          Map<String, dynamic> profileMap = jsonDecode(profileJson);

          var profile = Session.fromJson(profileMap);

          if(profile != null){
           return profile;
          }
        }

      }
    }

    return null;
  }

  static Future<Session> store(Session s) async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    var deleteResult = await databaseHelper.deleteAllRegistrationData();
    var insertResult =  await databaseHelper.insertRegistrationData({"data":s.toJsonString()});
    return s;
  }

  static Future<int> clear() async{
    DatabaseHelper databaseHelper = DatabaseHelper();
    var deleteResult = await databaseHelper.deleteAllRegistrationData();
    return deleteResult;
  }
}*/