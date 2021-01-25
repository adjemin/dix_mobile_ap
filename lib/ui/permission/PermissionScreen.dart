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
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {

  final Session session;

  const PermissionScreen(this.session);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();

}

class _PermissionScreenState extends State<PermissionScreen> {


  List<DixContact> elements = [];

  int _totalContacts = 0;



  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        body: new SingleChildScrollView(
          child: new Column(
            children: [

              SizedBox(height: 80.0,),

              Padding(
                  padding: EdgeInsets.all(50.0),
                  child:Image.asset("images/permission_image.png")
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text("Nous avons besoins de vos autorisation pour accéder à vos contacts.", textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff003F7C), fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text("Toutes les données seront traitées conformément à notre politique de confidentialités et de protection des données à caractères personnelles. ", textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30.0,),

              Button(
                width: MediaQuery.of(context).size.width,
                title: "SUIVANT",
                color: Theme.of(context).accentColor,
                titleColor: Colors.white,
                titleSize: 20,
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                onTap: (){

                  _askPermissions()
                      .whenComplete((){
                    loadData();
                  });

                },
              ),

              new SizedBox(height: 20,)

            ],
          ),
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

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    return  await Permission.contacts.request();
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
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


    Future.delayed(Duration(seconds: 1),(){


      LoginManager.saveContacts(result)
      .whenComplete((){

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new MainScreen(widget.session,result)));

      });


    });


  }
}



