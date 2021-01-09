import 'package:dixapp/util/IvoryCostPhoneUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class PhoneWidget extends StatefulWidget {

  final Phone phone;

  const PhoneWidget(this.phone);

  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          new Text(getPhoneText(widget.phone)),
          new SizedBox(width: 10,),
          Offstage(
            offstage: !IvoryCostPhoneUtil.isConverted(widget.phone),
            child: new Text("CONVERTI", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }

  String getPhoneText(Phone phone) {


    //return phone.normalizedNumber == null ? phone.number : phone.normalizedNumber;

    return phone.number == null ? "" : IvoryCostPhoneUtil.normalizePhoneNumber(phone.number);
  }


}
