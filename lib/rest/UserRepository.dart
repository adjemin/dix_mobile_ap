import 'dart:convert';

import 'package:dixapp/models/Session.dart';
import 'package:dixapp/rest/SubscriptionResult.dart';
import 'package:http/http.dart' as http;
import 'package:dixapp/util/Constants.dart';

class UserRepository{

  static Future<Session> login({
      String name,
      String dial_code,
      String phone_number,
      String email,
      Function showDialog,
      Function hideDialog

    })async{

    showDialog();

    var url = "${Constants.API_URL}auth/login";

    var response = await http
        .post(url, body: {
          'name': name,
          'dial_code': dial_code,
          'phone_number': phone_number,
          'email': email == null?"":email
    }, headers: {"Accept": "application/json"});

    hideDialog();

    print('=>>>>>>>>>>>>>>>>> login()  >>>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>> REQUEST  >>>>  ${response.request} >>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>>> RESPONSE STATUS CODE >>>>>>    ${response.statusCode} <<<<<<<<');
    print('=>>>>>>>>>>>>>>>>>> BODY >>>>>>    ${response.body}  <<<<<<');
    print('=>>>>>>>>>>>>>>>>>> login() >>>>>>>>>>>>>');

    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final Map resultMap = jsonDecode(jsonString);
      final Map data = resultMap['data'] as Map;

      final Session result = Session.fromJson(data);
      return result;
    } else {
      throw response;
    }




  }

  static Future<SubscriptionResult> subscribe({
    int customerId,
    Function showDialog,
    Function hideDialog
  })async{

    showDialog();

    var url = "${Constants.API_URL}customers/subscribe";

    var response = await http
        .post(url, body: {
      'customer_id':'$customerId'
    }, headers: {"Accept": "application/json"});

    hideDialog();

    print('=>>>>>>>>>>>>>>>>> subscribe()  >>>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>> REQUEST  >>>>  ${response.request} >>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>>> RESPONSE STATUS CODE >>>>>>    ${response.statusCode} <<<<<<<<');
    print('=>>>>>>>>>>>>>>>>>> BODY >>>>>>    ${response.body}  <<<<<<');
    print('=>>>>>>>>>>>>>>>>>> subscribe() >>>>>>>>>>>>>');

    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final Map resultMap = jsonDecode(jsonString);
      final Map data = resultMap['data'] as Map;

      final SubscriptionResult result = SubscriptionResult.fromJson(data);
      return result;
    } else {
      throw response;
    }




  }

  static Future<Session> setTried({
    int customerId,
    Function showDialog,
    Function hideDialog

  })async{

    showDialog();

    var url = "${Constants.API_URL}customers/set_tried";

    var response = await http
        .post(url, body: {
      'customer_id': '$customerId'
    }, headers: {"Accept": "application/json"});

    hideDialog();

    print('=>>>>>>>>>>>>>>>>> setTried()  >>>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>> REQUEST  >>>>  ${response.request} >>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>>> RESPONSE STATUS CODE >>>>>>    ${response.statusCode} <<<<<<<<');
    print('=>>>>>>>>>>>>>>>>>> BODY >>>>>>    ${response.body}  <<<<<<');
    print('=>>>>>>>>>>>>>>>>>> setTried() >>>>>>>>>>>>>');

    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final Map resultMap = jsonDecode(jsonString);
      final Map data = resultMap['data'] as Map;

      final Session result = Session.fromJson(data);
      return result;
    } else {
      throw response;
    }




  }

  static Future<Session> findUser({
    int customerId,
    Function showDialog,
    Function hideDialog

  })async{

    showDialog();

    var url = "${Constants.API_URL}customers/show/$customerId";

    var response = await http.get(url, headers: {"Accept": "application/json"});

    hideDialog();

    print('=>>>>>>>>>>>>>>>>> findUser()  >>>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>> REQUEST  >>>>  ${response.request} >>>>>>>>>>>>>');
    print(
        '=>>>>>>>>>>>>>>>>>> RESPONSE STATUS CODE >>>>>>    ${response.statusCode} <<<<<<<<');
    print('=>>>>>>>>>>>>>>>>>> BODY >>>>>>    ${response.body}  <<<<<<');
    print('=>>>>>>>>>>>>>>>>>> findUser() >>>>>>>>>>>>>');

    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final Map resultMap = jsonDecode(jsonString);
      final Map data = resultMap['data'] as Map;

      final Session result = Session.fromJson(data);
      return result;
    } else {
      throw response;
    }




  }
}