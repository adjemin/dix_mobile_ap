import 'package:dixapp/ui/welcome/slide/SlideWidget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: new PageView(
        children: [


          new SlideWidget(
            image: 'images/slide_1.png',
            title: "Passez de 8 à 10 chiffres tous vos numéros de téléphones Ivoiriens ",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dui purus, ultricies eu lectus vel, tempus tempor purus. ",
            onNext: (){

            },
          ),
          new SlideWidget(
            image: 'images/slide_2.png',
            title: "Partagez votre expérience avec vos proches ",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dui purus, ultricies eu lectus vel, tempus tempor purus. ",
            onNext: (){

            },
          )

        ],
      ),
    );
  }

}
