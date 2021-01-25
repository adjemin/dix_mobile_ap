import 'package:dixapp/ui/widgets/ContactWidget.dart';
import 'package:dixapp/util/dixcontact.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {

  final ScrollController scrollController;
  final List<DixContact> contacts;

  final Function onClickItem;


  const ContactListScreen(this.scrollController, this.contacts, this.onClickItem);

  @override
  _ContactListScreenState createState() => _ContactListScreenState();

}

class _ContactListScreenState extends State<ContactListScreen> {

  List<DixContact> selections = [];


  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: [
          new SizedBox(height: 10.0,),
       /*   new Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: 60.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 6.0, bottom: 6.0),
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

                Expanded(
                  child: TextField(

                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "Recherche"

                    ),

                  ),
                ),

                Container(
                  child: IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.search),
                  ),
                )

              ],
            ),
          ),*/

          _buildContactListUi(),

        ],
      ),
    );
  }

  Widget _buildContactListUi() {

    return new Column(
      children: widget.contacts.map((e) => new ContactWidget(
        contact: e,
        isSelected: selections.contains(e),
        call: (bool value){

         setState(() {
           if(value){
             if(!selections.contains(e)){
               selections.add(e);
             }
           }else{
             if(selections.contains(e)){
               selections.remove(e);
             }
           }
         });

          widget.onClickItem(selections, e);

        },
      )).toList(),
    );

  }

}
