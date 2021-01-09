import 'package:dixapp/ui/widgets/PhoneWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactWidget extends StatefulWidget {

  final Contact contact;
  final Function call;

  const ContactWidget({this.contact, this.call});

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
          new Container(
            child:GestureDetector(
              onTap: (){

                widget.call();

              },
              child:  new Container(
                child: Text("CONVERTIR", style: TextStyle(color: Colors.white),),
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ) ,
          )
        ],
      ),
    );
  }



  String getNameText(Contact contact) {

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
