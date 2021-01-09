import 'package:dixapp/ui/widgets/ContactWidget.dart';
import 'package:dixapp/util/Constants.dart';
import 'package:dixapp/util/IvoryCostPhoneUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  bool _loading = false;

  List<Contact> elements = [];

  int _totalContacts = 0;


  @override
  void initState() {
    super.initState();

    _askPermissions()
    .whenComplete((){
      loadData();
    });



  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("DIX ${_totalContacts} contacts trouvés"),
      ),
      body: new Stack(
        children: [
          new SingleChildScrollView(
            child: new Column(
              children: elements.map((e){
                return new ContactWidget(
                  contact:e,
                  call: ()async{

                    print("ok");
                    await IvoryCostPhoneUtil.convertPhone(e);

                  },
                );
              }).toList()
            ),
          ),
          Offstage(
            offstage: _loading,
            child: progressDialog(),
          )
        ],
      )
    );
  }

  void loadData() async {

    showProgress();

    final list = await fetchContacts();

    final data = list.take(40).toList();
    hideProgress();

    setState(() {
      elements = data;
    });
  }

  void showProgress(){

   if(mounted){
     setState(() {
       _loading = false;
     });
   }
  }

  void hideProgress(){
    if(mounted){
      setState(() {
        _loading = true;
      });
    }
  }

  Widget progressDialog(){

    return new Stack(
      children: [

        new Container(
          color: Colors.white,
        ),
        new Container(
          color: Colors.black.withOpacity(0.8),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        )

      ],
    );
  }


  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    return  await Permission.contacts.request();
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  Future<List<Contact>>  fetchContacts() async {

    List<Contact> contacts = await FlutterContacts.getContacts(withPhotos: false,);

    /// Listen to contacts database changes
    FlutterContacts.onChange((){

      print('Contact DB changed');

      fetchContacts();

    });

    List<Contact> results = [];

    try{
      for(Contact c in contacts){

        Contact contact = await FlutterContacts.getContact(c.id);
        if(contact != null){

          if(contact.phones == null || contact.phones.isEmpty) continue;

          for(Phone p in contact.phones){


            bool isValid = await isValidPhone(p);
            if(isValid){

              if(!results.contains(contact)){
                setState(() {
                  ++_totalContacts;
                });
                results.add(contact);
              }
            }


          }


          print(">>> contacts count $_totalContacts");
        }

        if(_totalContacts > 50){
          break;
        }



      }
    }catch(error){

      print("Error found >>> $error");

    }


    return results;


  }



  bool  isValidPhone(Phone phone) {

   return IvoryCostPhoneUtil.isValidNumber(phone.number);

  }

/*  Future<bool> isValidPhone(Phone phone)async{

    bool isValid = await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: phone.normalizedNumber, isoCode: COUNTRY_ISO);

    if(isValid){
      RegionInfo regionInfo = await PhoneNumberUtil.getRegionInfo(phoneNumber: phone.normalizedNumber, isoCode: COUNTRY_ISO);

      isValid = regionInfo.isoCode == COUNTRY_ISO;

      if(isValid){

        return true;

      }else{
        return false;
      }


    }else{

      return false;

    }
  }*/





}
