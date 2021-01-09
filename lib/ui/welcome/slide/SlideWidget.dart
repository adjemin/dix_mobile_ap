import 'package:dixapp/ui/widgets/Button.dart';
import 'package:flutter/material.dart';

class SlideWidget extends StatefulWidget {

  final String image;
  final String title;
  final String description;
  final Function onNext;

  const SlideWidget({this.image, this.title, this.description, this.onNext});

  @override
  _SlideWidgetState createState() => _SlideWidgetState();

}

class _SlideWidgetState extends State<SlideWidget> {

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [


        SizedBox(height: 20.0,),
        Padding(
            padding: EdgeInsets.all(50.0),
            child:Image.asset(widget.image)
        ),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(widget.title, textAlign: TextAlign.center,
           style: TextStyle(color: Color(0xff003F7C), fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(widget.description, textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20.0,),

        new Button(
          width: MediaQuery.of(context).size.width,
          title: "SUIVANT",
          color: Theme.of(context).accentColor,
          titleColor: Colors.white,
          titleSize: 20,
          margin: EdgeInsets.only(left: 25.0, right: 25.0),
          onTap: (){
            widget.onNext();
          },
        )
      ],
    );
  }

}
