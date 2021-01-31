package com.adjemin.dix

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, "dix_contacts").setMethodCallHandler{ call, result ->

            if(call.method == "getAllContacts"){

                val list = DixContactUtils.getAllContacts(this)

                if(list != null){
                    result.success(list)
                }else{
                    result.error("Error", "No contacts found",null)
                }


            }

            if(call.method == "updateAllContacts"){

                val args = call.arguments as List<*>

                val elements = args.map { it as Map<String, Any> }
                val r = DixContactUtils.updateAllContacts(this, elements)

                if(r != null){
                    result.success(r)
                }else{
                    result.error("Error", "Error found",null)
                }


            }


            if(call.method == "saveAllContacts"){

                val args = call.arguments as List<*>

                val elements = args.map { it as Map<String, Any> }
                val r = DixContactUtils.saveAllContacts(this, elements)

                if(r != null){
                    result.success(r)
                }else{
                    result.error("Error", "Error found",null)
                }


            }


        }

    }
}
