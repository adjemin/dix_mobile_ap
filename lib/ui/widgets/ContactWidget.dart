import 'package:dixapp/ui/widgets/PhoneWidget.dart';
import 'package:dixapp/util/dixcontact.dart';
import 'package:flutter/material.dart';

class ContactWidget extends StatefulWidget {

  final DixContact contact;
  final Function call;
  final bool isSelected;

  const ContactWidget({this.contact, this.call, this.isSelected});

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: new Row(
        children: [

          new Container(
            width: 50,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle
            ),
            child: Icon(Icons.person),
          ),
          new SizedBox(width: 10,),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(getNameText(widget.contact)),
                new Column(
                  children:  widget.contact.phones == null? [] : widget.contact.phones.map((e) => new PhoneWidget(e)).toList(),
                ),
              ],
            ),
          ),
        /*  new Container(
            child: new Checkbox(
                value: widget.isSelected,
                onChanged: (value){

                  widget.call(value);

                }),
          )*/
        ],
      ),
    );
  }



  String getNameText(DixContact contact) {

    if(contact.displayName == null){
      if(contact.normalizedName == null){
        print('${contact.normalizedName}');
        return "";

      }else{
        return "${contact.normalizedName??""}";
      }

    }else{

      return contact.displayName;
    }

  }
}
