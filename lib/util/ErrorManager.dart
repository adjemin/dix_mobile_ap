/**import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:adjemin/LangStrings.dart';
import 'package:adjemin/generic_ui/Dialogs.dart';

class ErrorManager{

  static backendErrorCatching(BuildContext context, dynamic error, Function onPositiveAction, Function onNegativeAction){

    if(error is SocketException){

      Dialogs.simpleError(context,  LangStrings.gs("Operation_Error"), LangStrings.gs("network_error_message"), onPositiveAction);

    }else if(error is Response){

      final String jsonString  = error.body;

      print("Error response $jsonString");

      if(error.statusCode >= 400 && error.statusCode < 500){

        final Map result = jsonDecode(jsonString);
        final String message = result['message'];

        Dialogs.simpleError(context,  LangStrings.gs("Operation_Error"),message, onPositiveAction);

      }else{
        Dialogs.simpleError(context,  LangStrings.gs("Operation_Error"), LangStrings.gs("internal_server_error_message"), onPositiveAction);

      }


    }else{
      Dialogs.simpleError(context,  LangStrings.gs("Operation_Error"), LangStrings.gs("internal_server_error_message"), onPositiveAction);

    }


  }
}*/