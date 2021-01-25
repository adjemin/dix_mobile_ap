import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dixapp/models/ContactResult.dart';
import 'package:dixapp/models/Session.dart';
import 'package:dixapp/ui/main/MainScreen.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/FlutterContacts.dart';
import 'package:dixapp/util/IvoryCostPhoneUtil.dart';
import 'package:dixapp/util/LoginManager.dart';
import 'package:dixapp/util/NotificationStatus.dart';
import 'package:dixapp/util/dixcontact.dart';
import 'package:dixapp/util/properties/phone.dart';
import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {

  final Session session;
  final int contactCount ;

  const ConversionScreen(this.session,this.contactCount);

  @override
  _ConversionScreenState createState() => _ConversionScreenState();

}

class _ConversionScreenState extends State<ConversionScreen> {

  List<DixContact> elements = [];

  int _totalContacts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultat de conversion"),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: [

            SizedBox(height: 50.0,),

            Container(
              child: Text("BRAVO !", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50.0, color: Theme.of(context).accentColor),),
            ),

            SizedBox(height: 20.0,),

            Container(
              child: Text("${widget.contactCount}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70.0),),
            ),
            Container(
              child: Text("contacts converti", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),),
            ),
            SizedBox(height: 20.0,),
            Button(
              width: MediaQuery.of(context).size.width,
              title: "TERMINER",
              color: Theme.of(context).accentColor,
              titleColor: Colors.white,
              titleSize: 20,
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              onTap: (){

                loadData();

              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildNotificationUI (String message, String status){

    switch(status){
      case SUCCESS:
        return new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: Text(message,   textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),),
        );
      case ERROR:
        return new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),),
        );
      case PENDING:
        return new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Text(message,    textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),),
        );

      case NONE:
        return new Container(
        );
      default:
        return new Container();
    }


  }
  void pushNotification( {String message, int duration, String status}) {

    print("pushNotification() >>> $message");
    BotToast.showCustomNotification(
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        duration: Duration(seconds: duration??1),
        backButtonBehavior: BackButtonBehavior.none,
        toastBuilder: (cancel) {
          return _buildNotificationUI(message,status);

        },
        enableSlideOff: true,
        onlyOne: true,
        crossPage: true);

  }

  void loadData() async {



    pushNotification(
        message: "Initialisation...",
        status: NotificationStatus.PENDING,
        duration: 3
    );

    await Future.delayed(Duration(seconds: 3),(){

    });


    final list = await fetchContacts();

    pushNotification(
        message: "Initialisation réussi!",
        status: NotificationStatus.SUCCESS,
        duration: 1
    );

    //final data = list.take(50).toList();
    final data = list.toList();

    elements = data;

    int moovCount = 0;
    int orangeCount = 0;
    int mtnCount = 0;

    int totalCount = 0;
    int totalConvertedCount = 0;
    int totalNoneConvertedCount = 0;



    pushNotification(
        message: "Décompte des contacts...",
        status: NotificationStatus.PENDING,
        duration: 3
    );
    await Future.delayed(Duration(seconds: 3),(){

    });

    for(DixContact contact in elements){

      final List<String> pListConverted = [];
      final List<String> pNoneConverted = [];

      for(Phone phone in contact.phones){

        String operator = IvoryCostPhoneUtil.operatorByPhoneNumber(phone.number);
        if(IvoryCostPhoneUtil.isConverted(phone)){
          pListConverted.add(phone.number);
          ++totalConvertedCount;
        }else{

          String phonePNNNormalized = IvoryCostPhoneUtil.getPhoneNumberConversion(phone.number);
          if(phonePNNNormalized!= null && phonePNNNormalized.isNotEmpty){
            bool hasContainPhoneConvertedVersion = contact.phones.where((element) => IvoryCostPhoneUtil.normalizePhoneNumber(element.number) == phonePNNNormalized).isNotEmpty;
            if(!hasContainPhoneConvertedVersion){
              pNoneConverted.add(phone.number);
              ++totalNoneConvertedCount;
            }
          }

        }

        if(operator != null){


          if(operator == "moov"){
            ++moovCount;
          }

          if(operator == "mtn"){
            ++mtnCount;
          }

          if(operator == "orange"){
            ++orangeCount;
          }

        }

      }

      totalCount = totalCount + pListConverted.length + pNoneConverted.length;

      pushNotification(
          message: "$totalCount contacts retrouvés...",
          status: NotificationStatus.PENDING,
          duration: 1
      );
      await Future.delayed(Duration(milliseconds: 150),(){

      });

    }

    ContactResult result = new ContactResult(
        contacts: elements,
        totalContactCount: elements.length ,
        totalNumberCount: totalCount,
        moovContactCount: moovCount,
        mtnContactCount: mtnCount,
        orangeContactCount: orangeCount,
        totalConvertedNumberCount: totalConvertedCount,
        totalNoneConvertedNumberCount: totalNoneConvertedCount
    );

    pushNotification(
        message: "Décompte terminé!",
        status: NotificationStatus.SUCCESS,
        duration: 3
    );


    Future.delayed(Duration(seconds: 1),()async{

      LoginManager.saveContacts(result)
          .whenComplete((){

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new MainScreen(widget.session,result)));

      });


    });


  }

  Future<List<DixContact>>  fetchContacts() async {

    pushNotification(
        message: "Recherche de contacts...",
        status: NotificationStatus.PENDING,
        duration: 1
    );

    await Future.delayed(Duration(seconds: 1),(){

    });

    List<DixContact> contacts = await FlutterContacts.getContacts();
    contacts.sort((d1,d2)=>d1.displayName.compareTo(d2.displayName));

    DixContact first = contacts.first;
    DixContact last = contacts.last;

    print('COUNT ${contacts.length}');
    print('FIRST ${first.displayName}');
    print('LAST ${last.displayName}');
    List<DixContact> results = [];

    try{
      for(DixContact c in contacts){

        DixContact contact = c;//await FlutterContacts.getContact(c.id);
        if(contact != null){

          contact.deduplicatePhones();

          if(contact.phones == null || contact.phones.isEmpty) continue;

          for(Phone p in contact.phones){


            bool isValid = IvoryCostPhoneUtil.isValidPhone(p);
            if(isValid){

              if(!results.contains(contact)){

                ++_totalContacts;

                results.add(contact);
                pushNotification(
                    message: "$_totalContacts contacts retrouvés",
                    status: NotificationStatus.PENDING,
                    duration: 1
                );

              }
            }

          }

          //print(">>> contacts count $_totalContacts");
        }

      /*  if(_totalContacts > 50){
          break;
        }*/

      }
    }catch(error){

      print("Error found >>> $error");

    }


    return results;


  }
}
