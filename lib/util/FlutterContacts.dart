import 'package:dixapp/util/dixcontact.dart';
import 'package:flutter/services.dart';

class FlutterContacts{

  static const MethodChannel dixContactChannel = const MethodChannel("dix_contacts");

  static Future<List<DixContact>> getContacts()async{
    List<DixContact> elements = [];

    try{

      List result = await dixContactChannel.invokeMethod('getAllContacts');

      elements = result.map((e) => DixContact.fromJson(e as Map)).toList();

      //print('_getContacts() >>> $elements');


    }on PlatformException catch(e){

      //elements = [];

      print("Error found $e");

    }

    return elements;

  }

   static Future updateContacts(List<DixContact> newContacts)async {

    try{

      List result = await dixContactChannel.invokeMethod('updateAllContacts', newContacts.map((e) => e.toJson()).toList());


      print('updateContacts() >>> $result');
      //print('updateContacts() >>> LAST NAME >>> ${newContacts.last.displayName}');


    }on PlatformException catch(e){

      //elements = [];

      print("Error found $e");

    }

  }

}