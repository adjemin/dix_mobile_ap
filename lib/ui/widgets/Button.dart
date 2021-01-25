import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final Color color;
  final String title;
  final TextStyle titleStyle;
  final Color titleColor;
  final double titleSize;
  final double width;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function onTap;
  final Color borderColor;

  Button({this.color, this.title, this.titleStyle, this.titleColor, this.titleSize,
    this.width, this.height, this.padding, this.margin,this.onTap, this.borderColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null? width: null,
      height: height != null? height: 60.0,
      margin: margin,
      child: new RaisedButton(
        onPressed: onTap,
        color: color,
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0), side: BorderSide(color: borderColor??Color(0x00000000))),
        child: new Padding(
          padding: padding == null? EdgeInsets.all(16.0): padding,

          child: new Text(title,style: titleStyle ==null? new TextStyle(color: titleColor != null? titleColor : Colors.white, fontWeight: FontWeight.bold, fontSize: titleSize == null ?16.0: titleSize):titleStyle,),
        ),
      ),
    );
  }
}
