import 'dart:io';

import 'package:adjeminpay_flutter/adjeminpay_flutter.dart';
import 'package:dixapp/cinetpay/CinetPaymentScreen.dart';
import 'package:dixapp/cinetpay/PaymentResponse.dart';
import 'package:dixapp/generic_ui/Dialogs.dart';
import 'package:dixapp/models/ContactResult.dart';
import 'package:dixapp/models/InvoicePayment.dart';
import 'package:dixapp/models/Session.dart';
import 'package:dixapp/rest/SubscriptionResult.dart';
import 'package:dixapp/rest/UserRepository.dart';
import 'package:dixapp/ui/auth/RegisterScreen.dart';
import 'package:dixapp/ui/main/AdsScreen.dart';
import 'package:dixapp/ui/main/ConversionScreen.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/Constants.dart';
import 'package:dixapp/util/FlutterContacts.dart';
import 'package:dixapp/util/IvoryCostPhoneUtil.dart';
import 'package:dixapp/util/LoginManager.dart';
import 'package:dixapp/util/NotificationStatus.dart';
import 'package:dixapp/util/dixcontact.dart';
import 'package:dixapp/util/properties/phone.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

import 'ContactListScreen.dart';

class MainScreen extends StatefulWidget {

  final Session session;
  final ContactResult contactResult;

  const MainScreen(this.session,this.contactResult);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String notificationStatus = "none";
  String notificationMessage = "";

  List<DixContact> unConvertedSelected  = [];
  List<DixContact> convertedSelected  = [];

  List<DixContact> _allConverted = [];
  List<DixContact> _allUnConverted = [];

  bool isTotallyFree = false;
  int freeLimit = 20;

  List<Widget> tabs = [];

  ScrollController scrollController = new ScrollController();

  ContactResult _result;

  int _totalContacts = 0;

  ProgressDialog pr;



  @override
  void initState() {
    super.initState();

    freeLimit = widget.session.subscription.free_limit;
    isTotallyFree = widget.session.subscription.is_totally_free;
    _result = widget.contactResult;

    pr = new ProgressDialog(context);
    pr.style(
      message: "Chargement...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      messageTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
    );


    _allUnConverted = filterPNN(_result.contacts, false);
    _allConverted = filterPNN(_result.contacts, true);

     setState(() {
       tabs = [
         new ContactListScreen(scrollController, _allUnConverted,onClickUnConvertedItem),
         new ContactListScreen(scrollController, _allConverted, onClickConvertedItem)
       ];
     });

    /// Listen to contacts database changes
   // FlutterContacts.onChange(()async{

     // print('Contact DB changed');

/*      setState(() {

        _allUnConverted = filterPNN(_result.contacts, false);
        _allConverted = filterPNN(_result.contacts, true);

        tabs = [
          new ContactListScreen(scrollController, _allUnConverted,onClickUnConvertedItem),
          new ContactListScreen(scrollController, _allConverted, onClickConvertedItem)
        ];
      });*/


    //});

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(Duration(seconds: 1),()async{

     var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> new AdsScreen()));


    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new SizedBox(width: 20,),
        title:  new Image.asset('images/logo_dix_blanc.png', height: 50.0,),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: (){

            Share.share("Je t'invite à télécharger DIX  pour basculer de 8 à 10 chiffres ton repertoire https://play.google.com/store/apps/details?id=com.adjemin.dix");

          }),

          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){

            LoginManager.signOut()
                .whenComplete((){

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new RegisterScreen()));


            });
          })
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child:  new Column(
          children: [

            new Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Color(0xffD2E5F3)
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  new Text("Mes Contacts (${_result.contacts.length})", style: TextStyle(color: Color(0xff003F7C), fontSize: 18.0, fontWeight: FontWeight.bold),),


                ],
              ),
            ),

            _buildNotificationUI (),

            new SizedBox(height: 5,),

            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  new Container(
                    width: (MediaQuery.of(context).size.width / 3 ) - 15,
                    height: (MediaQuery.of(context).size.width / 3 ) - 30,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Color(0xffD8DBDD).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Color(0xffAFAEAE).withOpacity(0.4))

                    ),
                    child: new Column(
                      children: [

                        new Row(
                          children: [

                            new Image.asset("images/logo_mtn.png"),
                            new SizedBox(width: 10.0,),
                            new Text("${_result.mtnContactCount}", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                          ],
                        ),
                        new SizedBox(height: 3.0,),
                        new Text("MTN", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                      ],
                    ),
                  ),

                  new Container(
                    width: (MediaQuery.of(context).size.width / 3 ) - 15,
                    height: (MediaQuery.of(context).size.width / 3 ) - 30,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Color(0xffD8DBDD).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Color(0xffAFAEAE).withOpacity(0.4))

                    ),
                    child: new Column(
                      children: [

                        new Row(
                          children: [

                            new Image.asset("images/logo_orange.png"),
                            new SizedBox(width: 10.0,),
                            new Text("${_result.orangeContactCount}", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                          ],
                        ),
                        new SizedBox(height: 3.0,),
                        new Text("ORANGE", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                      ],
                    ),
                  ),

                  new Container(
                    width: (MediaQuery.of(context).size.width / 3 ) - 15,
                    height: (MediaQuery.of(context).size.width / 3 ) - 30,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Color(0xffD8DBDD).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Color(0xffAFAEAE).withOpacity(0.4))

                    ),
                    child: new Column(
                      children: [

                        new Row(
                          children: [

                            new Image.asset("images/logo_moov.png"),
                            new SizedBox(width: 10.0,),
                            new Text("${_result.moovContactCount}", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                          ],
                        ),
                        new SizedBox(height: 3.0,),
                        new Text("MOOV", style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0, fontWeight: FontWeight.bold),)

                      ],
                    ),
                  )



                ]
            ),

            new SizedBox(height: 10,),
            convertedSelected.isNotEmpty?new Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: Text("${convertedSelected.length} contacts basculés sélèctionné",   textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0,color: Colors.white, fontWeight: FontWeight.bold),),
            ): new Container(),

            unConvertedSelected.isNotEmpty?new Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: Text("${unConvertedSelected.length} contacts non basculés sélèctionné",   textAlign: TextAlign.center,style: TextStyle(fontSize: 14.0,color: Colors.white, fontWeight: FontWeight.bold),),
            ): new Container(),

            new Button(
              width: MediaQuery.of(context).size.width,
              title: "Passez à 10",
              color: Theme.of(context).accentColor,
              titleColor: Colors.white,
              titleSize: 20,
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              onTap: (){

                if(widget.session.user.is_paid_subscription){
                  launchConversion(0);
                }else{
                  var customWidget  = Container(
                    child: new Column(
                      children: [

                        Container(
                          child: Text("Essayez de basculer $freeLimit contacts gratuitement ou  basculez tout votre repertoire à",
                            style: TextStyle(fontSize: 18.0,color: Colors.black),
                          ),
                        ),

                        Container(
                          child: Text("${widget.session.subscription.price.toInt()}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 70.0),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text("FCFA", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),),
                        ),
                      ],
                    ),
                  );

                  Dialogs.customViewDialog(context,
                      customWidget: customWidget,
                      positiveButtonLabel: 'PAYER',
                      negativeButtonLabel: 'ESSAYER',
                      onPositive: (){

                        pay();

                      },
                      onNegative: (){

                        if(widget.session.user.is_tried){


                          Toast.show("Vous avez déjà essayé le basculement vous devez maintenant payer afin de finaliser.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red,textColor: Colors.white);

                          return;

                        }else{
                          tryConversion();
                        }


                      }
                  );
                }




                //startConversion();

              },
            ),
            new SizedBox(height: 10,),
            new Button(
              width: MediaQuery.of(context).size.width,
              title: "Revenir à 8",
              color: Color(0xffECF1F5),
              titleColor: Theme.of(context).primaryColorDark,
              titleSize: 20,
              borderColor: Color(0xff87B7EA).withOpacity(0.4),
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              onTap: (){

                startUnConversion();

              },
            ),

            new SizedBox(height: 20,),

            new Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Color(0xffECF1F5)
              ),
              child: new TabBar(

                tabs: [
                  Tab(text: "NON BASCULE (${_allUnConverted.length})",),

                  Tab( text: "BASCULE (${_allConverted.length})"),

                ],
                labelColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                indicatorWeight: 6.0,
              ),
            ),

            new Expanded(
              child: TabBarView(
                children: tabs,
              ),
            )


          ],
        ),
      ),
    );
  }

  Widget _buildNotificationUI (){

    switch(notificationStatus){
      case SUCCESS:
        return new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: Text(notificationMessage,   textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),),
        );
      case ERROR:
        return new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text(notificationMessage,
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
          child: Text(
            notificationMessage,    textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.bold),),
        );

      case NONE:
        return new Container(
        );
      default:
        return new Container();
    }


  }

  void pushNotification( {String message, int duration, String status, int delay})async{

    Future.delayed(Duration(seconds: delay ?? 0)).then((_) {

      if(mounted){
        setState(() {
          notificationMessage = message;
          notificationStatus = status;
        });
      }

      if (duration != null && duration > 0) {
        Future.delayed(Duration(seconds: duration ?? 3))
            .then((value){
          if(mounted){

            setState((){
              notificationMessage = "";
              notificationStatus = NONE;
            });
          }
        }

        );
      }
    });

  }

  List<DixContact> filterPNN(List<DixContact> contacts, bool hasPNN) {

    List<DixContact> list = [];

    for(DixContact contact in contacts){

      final List<String> pListConverted = [];
      final List<String> pNoneConverted = [];

      for(Phone phone in contact.phones){

        if(IvoryCostPhoneUtil.isConverted(phone)){
          pListConverted.add(phone.number);
        }else{

          String phonePNNNormalized = IvoryCostPhoneUtil.getPhoneNumberConversion(phone.number);
          //print("phonePNNNormalized >>> $phonePNNNormalized");
          if(phonePNNNormalized!= null && phonePNNNormalized.isNotEmpty){
            bool hasContainPhoneConvertedVersion = contact.phones.where((element) => IvoryCostPhoneUtil.normalizePhoneNumber(element.number) == phonePNNNormalized).isNotEmpty;
            if(!hasContainPhoneConvertedVersion){
              pNoneConverted.add(phone.number);
            }
          }

        }

      }

      if(hasPNN){
        if(!pNoneConverted.isNotEmpty){
          list.add(contact);
        }
      }else{
        if(pNoneConverted.isNotEmpty){
          list.add(contact);
        }
      }


    }

    return list;

  }

  void onClickUnConvertedItem(List<DixContact> elements, DixContact selected){

    setState(() {
      unConvertedSelected = elements;
    });


  }

  void onClickConvertedItem(List<DixContact> elements, DixContact selected){
    setState(() {
      convertedSelected = elements;
    });
  }

  void tryConversion() {

      launchConversion(freeLimit);

  }

  void startConversion() {


      launchConversion(0);


  }

  void startUnConversion() {

      unLaunchConversion();

  }

  void launchConversion(int limit) async{

    List<DixContact> contacts  = [];
    List<DixContact> contactListConverted  = [];
    if(unConvertedSelected.isNotEmpty){

      if(limit == 0){
        contacts = unConvertedSelected;
      }else{
        contacts = unConvertedSelected.take(limit).toList();
      }
    }else{
      if(limit == 0){
        contacts = _allUnConverted;
      }else{
        contacts = _allUnConverted.take(limit).toList();
      }
    }

    if(contacts.isNotEmpty){
      int contactCount = 0;


      for(DixContact contact in contacts){


        DixContact newContact = await IvoryCostPhoneUtil.convertPhone(contact);
        contactListConverted.add(newContact);

        ++contactCount;

        print('Iteration >>>> $contactCount');

        pushNotification(
          message: "$contactCount / ${contacts.length} converti...",
          status: NotificationStatus.PENDING,
          duration: 1
        );

        await Future.delayed(Duration(seconds: 1),(){

        });


      }

      // Display message: "Traitement en cours..."
      pushNotification(
          message: "Sauvregarde en cours...",
          status: NotificationStatus.PENDING,
          duration: 3
      );

     var updateResult = await FlutterContacts.updateContacts(contactListConverted);

     if(updateResult != null){
       pushNotification(
           message: "$contactCount converti !",
           status: NotificationStatus.SUCCESS,
           duration: 3
       );
     }


      setState(() {
        unConvertedSelected = [];
      });

     if(limit != 0){

       saveTried(limit);
     }else{
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new ConversionScreen(widget.session,contactListConverted.length)));
     }

    }

  }

  void unLaunchConversion() async{

    List<DixContact> contacts  = [];
    List<DixContact> contactListConverted  = [];
    if(convertedSelected.isNotEmpty){

        contacts = convertedSelected;

    }else{

        contacts = _allConverted;

    }

    if(contacts.isNotEmpty){

      int contactCount = 0;
      for(DixContact contact in contacts){

        DixContact newContact = await IvoryCostPhoneUtil.unConvertPhone(contact);
        contactListConverted.add(newContact);

        ++contactCount;

        pushNotification(
          message: "$contactCount / ${contacts.length} converti...",
          status: NotificationStatus.PENDING,
          duration: 1
        );

        await Future.delayed(Duration(seconds: 1),(){

        });

      }

      // Display message: "Traitement en cours..."
      pushNotification(
          message: "Sauvregarde en cours...",
          status: NotificationStatus.PENDING,
          duration: 3
      );

      var updateResult = await FlutterContacts.updateContacts(contactListConverted);
      print("UPDATE >>> $updateResult");

      if(updateResult != null){
        pushNotification(
            message: "$contactCount converti !",
            status: NotificationStatus.SUCCESS,
            duration: 3
        );
      }

      setState(() {
        convertedSelected = [];
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new ConversionScreen(widget.session,contactListConverted.length)));

    }


  }


  void showProgress(){
    pr.show();
  }
  void hideProgress(){
    pr.hide();
  }



  void saveTried(int count) {

    UserRepository.setTried(
      customerId: widget.session.user.id,
      showDialog: showProgress,
      hideDialog: hideProgress
    ).then((value){

      LoginManager.signIn(value).whenComplete(() {

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ConversionScreen(value,count)));

      });

    })
    .catchError((onError){

      if(onError is SocketException){

        Dialogs.simpleError(context,  "Erreur rencontrée", "Verifiez votre connexion internet !", (){



        });


      }else{

        Dialogs.simpleError(context,  "Erreur rencontrée", "Nous avons rencontré un problème lors de la connexion au serveur.", (){



        });
      }

    });



  }

  void pay() {

    UserRepository.subscribe(
        customerId: widget.session.user.id,
        showDialog: showProgress,
        hideDialog: hideProgress
    ).then((SubscriptionResult value){


        if(value != null){

          if(value.transaction != null){

            //goToCinetPayPayment(value.transaction);
            payWithAdjeminPay(value.transaction);

          }

        }

    })
        .catchError((onError){

      if(onError is SocketException){

        Dialogs.simpleError(context,  "Erreur rencontrée", "Verifiez votre connexion internet !", (){



        });


      }else{

        Dialogs.simpleError(context,  "Erreur rencontrée", "Nous avons rencontré un problème lors de la connexion au serveur.", (){



        });
      }

    });



  }

  void goToCinetPayPayment(InvoicePayment data) async {


    PaymentResponse paymentResponse = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CinetPaymentScreen(
          Constants.CINET_PAY_API_KEY,
          Constants.CINET_PAY_SITE_ID,
          Constants.CINET_PAY_NOTIFICATION_URL,
          double.parse(data.amount.toString()),
          data.payment_reference,
          data.currency_code,
          "Abonnement PNN",
          "",
        ),
      ),
    );

    if (paymentResponse != null) {
      if (paymentResponse.success) {

        Dialogs.showSuccess(context, "Paiement Réussi!", 'Votre paiement a été effectué', (){

          updateUser((){

            launchConversion(0);

          });

        });

      } else {

        Dialogs.simpleError(context, 'Erreur rencontrée', "Le paiement n'a pas été effectué", (){

        });

      }
    } else {
      Dialogs.simpleError(context, 'Erreur rencontrée', "Le paiement n'a pas été effectué", (){

      });
    }

  }

  void updateUser(Function action) {

    UserRepository.findUser(
        customerId: widget.session.user.id,
        showDialog: showProgress,
        hideDialog: hideProgress
    ).then((value){

      LoginManager.signIn(value).whenComplete(() {


        action();

      });

    })
        .catchError((onError){

      if(onError is SocketException){

        Dialogs.simpleError(context,  "Erreur rencontrée", "Verifiez votre connexion internet !", (){



        });


      }else{

        Dialogs.simpleError(context,  "Erreur rencontrée", "Nous avons rencontré un problème lors de la connexion au serveur.", (){



        });
      }

    });



  }

  void payWithAdjeminPay(InvoicePayment data) async {

    print('DISPLAY  TRANSACTION >>> ${data.toJson()}');
    Map<String, dynamic> paymentResult = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => AdjeminPay(
            apiKey: Constants.ADJEMINPAY_API_KEY,
            applicationId: Constants.ADJEMINPAY_APPLICATION_ID,
            transactionId: "${data.payment_reference}",
            notifyUrl: Constants.ADJEMINPAY_NOTIFICATION_URL,
            amount: int.parse("${data.amount}"),
            currency: data.currency_code,
            designation:  "Abonnement PNN",
            // designation: widget.element.title,
            payerName: widget.session.user.name,

          ),
        ));

    print(">>>>>>>>>> PAYMENT RESULTS <<<<<<<<<<<<");
    print(paymentResult);

    if (paymentResult != null) {
      if (paymentResult['status'] == "SUCCESSFUL") {
        onPaymentSuccess();
      } else {
        Dialogs.simpleError(context, 'Erreur rencontrée', "Le paiement n'a pas été effectué", (){

        });
      }
    } else {

      Dialogs.simpleError(context, 'Erreur rencontrée', "Le paiement n'a pas été effectué", (){

      });

    }
  }

  void onPaymentSuccess() {

    Dialogs.showSuccess(context, "Paiement Réussi!", 'Votre paiement a été effectué', (){

      updateUser((){

        launchConversion(0);

      });

    });

  }



}
