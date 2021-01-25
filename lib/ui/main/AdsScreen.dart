import 'dart:io';
import 'package:dixapp/util/Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:flutter/material.dart';

class AdsScreen extends StatefulWidget {

  @override
  _AdsScreenState createState() => _AdsScreenState();

}

class _AdsScreenState extends State<AdsScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Column(
        children: [


          Container(
            padding: EdgeInsets.all(20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12,
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  onTap: (){

                    Navigator.pop(context, true);

                  },
                ),


              ],
            ),
          ),

          Container(
            child: Text( "Acheter, vendre, négocier avec Adjemin", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).accentColor,fontSize: 25, fontWeight: FontWeight.bold),),
          ),

          Image.asset('assets/people.png'),

          Container(
            child: Text( "Rejoignez la communauté Adjemin", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20),
          if (Platform.isAndroid)
            Button(
              width: MediaQuery.of(context).size.width,
              title: "Télécharger l'application",
              color: Theme.of(context).accentColor,
              titleColor: Colors.white,
              titleSize: 18,
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              onTap: (){

                launchURL(Constants.ADJEMIN_ANDROID);
                Navigator.pop(context);

              },
            ),
          if (Platform.isIOS)
            Button(
              width: MediaQuery.of(context).size.width,
              title: "Télécharger l'application",
              color: Theme.of(context).accentColor,
              titleColor: Colors.white,
              titleSize: 18,
              margin: EdgeInsets.only(left: 25.0, right: 25.0),
              onTap: (){
                launchURL(Constants.ADJEMIN_IOS);

              },
            ),
          SizedBox(height: 20),




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

}
