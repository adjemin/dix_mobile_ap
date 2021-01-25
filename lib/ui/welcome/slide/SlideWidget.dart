
import 'package:flutter/material.dart';

class SlideWidget extends StatefulWidget {

  final String image;
  final String title;
  final String description;
  const SlideWidget({this.image, this.title, this.description});

  @override
  _SlideWidgetState createState() => _SlideWidgetState();

}

class _SlideWidgetState extends State<SlideWidget> {

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: [


          SizedBox(height: 20.0,),
          Image.asset(widget.image,height: MediaQuery.of(context).size.height - 400.0,),
          SizedBox(height: 20.0,),
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

        ],
      ),
    );
  }

}
