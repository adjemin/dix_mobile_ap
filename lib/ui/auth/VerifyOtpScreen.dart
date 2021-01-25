import 'dart:io';

import 'package:dixapp/generic_ui/Dialogs.dart';
import 'package:dixapp/models/Session.dart';
import 'package:dixapp/rest/UserRepository.dart';
import 'package:dixapp/ui/permission/PermissionScreen.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/LoginManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class VerifyOtpScreen extends StatefulWidget {

  final String name;
  final String email;
  final String dialCode;
  final String phoneNumber;
  final String countryCode;


  const VerifyOtpScreen(this.name, this.email,this.dialCode, this.phoneNumber, this.countryCode);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  bool _loading = true;

  TextEditingController codeController = new TextEditingController();

  String phone = "";

  static const String TAG = "VerifyOTPScreen";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  Future<Null> _verifyPhoneNumber() async {
    print("$TAG Got phone number as: $phone");

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential authCredential) {
      print('verified');
      // phoneLogin();
      login();

    };

    final PhoneVerificationFailed verifiedFailed = (error) {
      print('Error ' + error.message);
      Dialogs.simpleError(context, 'Operation Error', error.message, () {});
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "$phone",
        timeout: const Duration(seconds: 5),
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed);
    print("$TAG Returning null from _verifyPhoneNumber");
    return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      phone = '+${widget.dialCode}${widget.phoneNumber}';

    });

    _verifyPhoneNumber().then((Null) {
      print("$TAG Code Sent");
    });
  }



  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      body: new Stack(
        children: [
          new SingleChildScrollView(
            child: new Column(
              children: [

                SizedBox(height: 50.0,),
                SizedBox(height: 50.0,),


                //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Vérification numéro de téléphone ", textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff003F7C), fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("+${widget.dialCode} ${widget.phoneNumber} ", textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 20.0,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Saisissez le code reçu par sms", textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff003F7C), fontSize: 16.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 6.0, bottom: 6.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color:  Color(0xff2581C5).withOpacity(0.2),
                          width: 1.8
                      )
                  ),
                  child: TextField(
                    controller: codeController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '000000',
                        hintStyle: TextStyle(color: Color(0xff707070), fontSize: 18.0)
                    ),
                  ),
                ),

                new SizedBox(height: 50,),
                new Button(
                  width: MediaQuery.of(context).size.width,
                  title: "VERIFIER",
                  color: Theme.of(context).accentColor,
                  titleColor: Colors.white,
                  titleSize: 20,
                  margin: EdgeInsets.only(left: 25.0, right: 25.0),
                  onTap: (){

                    verify();

                  },
                ),
                new SizedBox(height: 20,),
                new Button(
                  width: MediaQuery.of(context).size.width,
                  title: "RENVOYER",
                  color: Color(0xffD2E5F3),
                  titleColor: Theme.of(context).primaryColorDark,
                  titleSize: 20,
                  margin: EdgeInsets.only(left: 25.0, right: 25.0),
                  onTap: (){

                    _verifyPhoneNumber().then((Null) {
                      print("$TAG Code Sent");
                    });

                  },
                ),
                new SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new RegisterScreen()));
                    },
                    child: Text("Retour", textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff003F7C), fontSize: 20.0, decoration: TextDecoration.underline),
                    ),
                  ),
                ),

                new SizedBox(height: 50,)



              ],
            ),
          ),
          new Offstage(
            offstage: _loading,
            child: progressView(),
          )

        ],
      ),
    );
  }

  void login() {
    UserRepository.login(
      name: widget.name,
      email: widget.email,
      dial_code: widget.dialCode,
      phone_number: widget.phoneNumber,
      showDialog: showProgress,
      hideDialog: hideProgress
    )
        .then((Session value) {
      if (value != null) {
        LoginManager.signIn(value).whenComplete(() {

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PermissionScreen(value)));

        });
      }
    }).catchError((onError) {
      print("Error $onError");

      if(onError is SocketException){

        Dialogs.simpleError(context,  "Erreur rencontrée", "Verifiez votre connexion internet !", (){



        });


      }else{

        Dialogs.simpleError(context,  "Erreur rencontrée", "Nous avons rencontré un problème lors de la connexion au serveur.", (){



        });
      }



    });
  }

  Widget progressView() {
    return new Stack(
      children: [
        new Container(
          color: Colors.white,
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
      ],
    );
  }

  void showProgress() {
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  void hideProgress() {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
  }


  void verify() {
    if (codeController.text.isEmpty) {
      Dialogs.simpleError(context, 'Erreur Rencontrée',
          'Entrez un code de vérification SVP', () {});

      return;
    }

    showProgress();

    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: codeController.text);
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      print("$TAG Code Verified with Success");
      //phoneLogin();
      login();

    }).catchError((e) {
      hideProgress();
      print(e);

      Dialogs.simpleError(context, 'Erreur rencontré', e.message, () {});
    });
  }



}
