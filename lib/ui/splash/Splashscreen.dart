import 'package:dixapp/ui/welcome/WelcomeScreen.dart';
import 'package:dixapp/ui/widgets/Button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(Duration(seconds: 3), (){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new WelcomeScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new Column(
        children: [

          new Expanded(
            child: new Center(
              child:new Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child:  new Image.asset('images/logo_dix_blanc.png'),//
              )
            ),
          ),


          new Container(
            padding: EdgeInsets.all(20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text('Une solution de Adjemin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                new SizedBox(width: 10.0,),
                new Image.asset("images/logo_adjemin.png", height: 50.0,)
              ],
            )
          )
        ],
      ),
    );
  }

}
