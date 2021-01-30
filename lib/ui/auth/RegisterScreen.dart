import 'dart:io';

import 'package:dixapp/ui/auth/VerifyOtpScreen.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/Constants.dart';
import 'package:dixapp/util/country_picker/flutter_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flare_checkbox/flare_checkbox.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dixapp/generic_ui/Dialogs.dart';
import 'package:dixapp/rest/UserRepository.dart';
import 'package:dixapp/util/LoginManager.dart';
import 'package:dixapp/ui/permission/PermissionScreen.dart';
import 'package:dixapp/models/Session.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _loading = true;

  Country _currentCountry;

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneNumberController = new TextEditingController();

  bool  _isTermsAccepted = true;

  @override
  void initState() {

    super.initState();

    _currentCountry = Country.CI;
    phoneNumberController.text = "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new Stack(
        children: [
          new SingleChildScrollView(
            child: new Column(
              children: [

                SizedBox(height: 20.0,),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child:ClipOval(
                      child: Image.asset("images/register_image.png", height: 200.0,),
                    )
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Entrez vos informations personnelles", textAlign: TextAlign.center,
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
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nom & Prénoms (*)',
                        hintStyle: TextStyle(color: Color(0xff707070), fontSize: 18.0)
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email (facultatif)',
                        hintStyle: TextStyle(color: Color(0xff707070), fontSize: 18.0)
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color:  Color(0xff2581C5).withOpacity(0.2),
                          width: 1.8
                      )
                  ),
                  child: new Row(
                    children: [
                      CountryPicker(
                        onChanged: (Country country) {
                          setState(() {
                            _currentCountry = country;
                          });
                        },
                        selectedCountry: _currentCountry,
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '00 00 00 00 (*)',
                              hintStyle: TextStyle(color: Color(0xff707070), fontSize: 18.0)
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    new Container(
                      width: 80.0,
                      height: 80.0,
                      child: FlareCheckbox(
                        onChanged: (value){


                          setState(() {
                            _isTermsAccepted = value;
                          });
                          print("OK $value");

                        },
                        animation: 'assets/checkbox.flr',
                        value: _isTermsAccepted,
                      ),
                    ),
                    new Expanded(
                      child: new Column(
                        children: [
                          new Text("Je reconnais avoir lu et compris"),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: (){
                      launchURL(Constants.TERMS);
                    },
                    child: Text("les conditions d'utilisation et la politique de confidentialité", textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff003F7C), fontSize: 14.0, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                new SizedBox(height: 20,),
                new Button(
                  width: MediaQuery.of(context).size.width,
                  title: "COMMENCER",
                  color: Theme.of(context).accentColor,
                  titleColor: Colors.white,
                  titleSize: 20,
                  margin: EdgeInsets.only(left: 25.0, right: 25.0),
                  onTap: (){

                    if(nameController.text.isEmpty){
                      Toast.show("Nom et Prénoms sont obligatoires", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red,textColor: Colors.white);

                      return;
                    }

                    if(phoneNumberController.text.isEmpty){
                      Toast.show("Téléphone est obligatoire", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red,textColor: Colors.white);

                      return;
                    }

                    if(!_isTermsAccepted){
                      Toast.show("Vous devez accepter les CGU avant de poursuivre.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red,textColor: Colors.white);

                      return;
                    }

                    login();


                    /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new VerifyOtpScreen(
                        nameController.text,
                        emailController.text,
                        _currentCountry.dialingCode,
                        phoneNumberController.text,
                        _currentCountry.isoCode
                    )));*/


                  },
                ),

                new SizedBox(height: 20,)



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

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
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

  void login() {
    UserRepository.login(
        name: nameController.text,
        email: emailController.text,
        dial_code: _currentCountry.dialingCode,
        phone_number: phoneNumberController.text,
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
}
