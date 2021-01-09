import 'package:dixapp/ui/widgets/Button.dart';
import 'package:dixapp/util/country_picker/flutter_country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flare_checkbox/flare_checkbox.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Country _currentCountry;

  final TextEditingController phoneNumberController = new TextEditingController();

  @override
  void initState() {

    super.initState();

    _currentCountry = Country.CI;
    phoneNumberController.text = "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
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
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dui purus,", textAlign: TextAlign.center,
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nom & Prénoms',
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '00 00 00 00',
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

                      print("OK $value");

                    },
                    animation: 'assets/checkbox.flr',
                    value: true,
                  ),
                ),
                new Expanded(
                  child: new Column(
                    children: [
                      new Text("Je reconnais avoir lu et compris la politique"),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing,", textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff003F7C), fontSize: 14.0, decoration: TextDecoration.underline),
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



              },
            ),

            new SizedBox(height: 20,)
            

            
          ],
        ),
      ),
    );
  }
}
