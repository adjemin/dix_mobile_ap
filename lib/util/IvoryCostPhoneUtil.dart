import 'package:flutter_contacts/flutter_contacts.dart';

class IvoryCostPhoneUtil{

  static final operators = [
    "orange",
    "mtn",
    "moov"
  ];

  static final mobileOperators = {
    "orange" : "07",
    "mtn": "05",
    "moov": "01"
  };

 static  final fixedLineOperators = {
    "orange" : "27",
    "mtn": "25",
    "moov": "21"
  };

  static final mobilePrefixesCI = ["07", "08", "09", "47", "48", "49", "57", "59", "67", "68", "69", "77", "78", "87", "88", "89", "97", "98"
    ,"04", "05", "06", "44", '45', "46", "54", "55", "56", "64", "65", "66", "74", "75", "76", "84", "85", "86", "94", "95", "96",
    "01", "02", "03", "40", "41", "42", "43", "50", "51", "52", "53", "70", "71", "72", "73"];

  static final fixedLineOperatorsPrefixesCI = ["202", "203", "212", "213","215", "217", "224", "225", "234", "235", "243", "244", "245", "306", "316", "319", "327", "337", "347","359", "368",
    "200", "210", "220", "230", "240", "300", "310", "320", "330", "340", "350", "360",
    "208", "218", "228", "238"];

  static final mobileOperatorsPrefixes = {
    "orange" : ["07", "08", "09", "47", "48", "49", "57", "59", "67", "68", "69", "77", "78", "87", "88", "89", "97", "98"],
    "mtn": ["04", "05", "06", "44", '45', "46", "54", "55", "56", "64", "65", "66", "74", "75", "76", "84", "85", "86", "94", "95", "96"],
    "moov": ["01", "02", "03", "40", "41", "42", "43", "50", "51", "52", "53", "70", "71", "72", "73"]
  };


  static final fixedLineOperatorsPrefixes = {
    "orange" : ["202", "203", "212", "213","215", "217", "224", "225", "234", "235", "243", "244", "245", "306", "316", "319", "327", "337", "347","359", "368"],
    "mtn": ["200", "210", "220", "230", "240", "300", "310", "320", "330", "340", "350", "360"],
    "moov": ["208", "218", "228", "238"]
  };




 static  bool isConverted(Phone phone) {

    String phoneNumber  = phone.number;

    phoneNumber = phoneNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "");

    if(isIvorianNumber(phoneNumber)){

      String digitNumber = simpleNumber(phoneNumber);

      return digitNumber.length == 10;

    }else{

      return false;

    }

  }

  static String operatorByPhoneNumber(String phoneNumber){

    if(isIvorianNumber(phoneNumber)){

        final String digitNumber = simpleNumber(phoneNumber);

        final String prefix = getOperatorPrefix(digitNumber);

        String operator = "";

        if(digitNumber.length == 8){
          if(isMobile(digitNumber)){

            for(MapEntry<String, List<String>> item in mobileOperatorsPrefixes.entries.toList()){

              if(item.value.contains(prefix)){
                operator = item.key;
                break;
              }

            }

          }else{
            for(MapEntry<String, List<String>> item in fixedLineOperatorsPrefixes.entries.toList()){

              if(item.value.contains(prefix)){
                operator = item.key;
                break;
              }

            }
          }


        }

        if(digitNumber.length == 10){
          if(isMobile(digitNumber)){

            for(MapEntry<String, List<String>> item in mobileOperatorsPrefixes.entries.toList()){

              if(item.value.contains(prefix)){
                operator = item.key;
                break;
              }

            }

          }else{

            if(prefix  == "21"){
              operator = "moov";
            }

            if(prefix == "25"){
              operator ="mtn";
            }

            if(prefix == "27"){
              operator = "orange";
            }


          }


        }

        return operator;

      }else{
       return "none";
     }






  }

  static String simpleNumber(String phoneNumber){

    phoneNumber = phoneNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    String digitNumber = phoneNumber;

    if(phoneNumber.length > 8){
      if(phoneNumber.startsWith("225") || phoneNumber.startsWith("00225") || phoneNumber.startsWith("+225")){

        if(phoneNumber.startsWith("225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("225") +3, phoneNumber.length);
        }

        if(phoneNumber.startsWith("00225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("00225") +5, phoneNumber.length);
        }

        if(phoneNumber.startsWith("+225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("+225") +4, phoneNumber.length);
        }

        return digitNumber;

      }else{
        return digitNumber;
      }
    }else{
      return digitNumber;
    }
  }

  static String normalizePhoneNumber(String number){

   if(isIvorianNumber(number)){
     String phoneNumber  = number;
     phoneNumber = phoneNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "");

     String digitNumber = simpleNumber(phoneNumber);

     return "+225"+digitNumber;
   }else{

     return number;
   }

  }
  static bool isIvorianNumber(String number){

    String phoneNumber  = number;
    phoneNumber = phoneNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "");

    String digitNumber = "";

    if(phoneNumber.length > 8){
      if(phoneNumber.startsWith("225") || phoneNumber.startsWith("00225") || phoneNumber.startsWith("+225")){

        if(phoneNumber.startsWith("225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("225") +3, phoneNumber.length);
        }

        if(phoneNumber.startsWith("00225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("00225") +5, phoneNumber.length);
        }

        if(phoneNumber.startsWith("+225")){
          digitNumber = phoneNumber.substring(phoneNumber.indexOf("+225") +4, phoneNumber.length);
        }

        return hasOperatorsPrefixesCI(digitNumber);


      }else{
        return hasOperatorsPrefixesCI(phoneNumber);
      }
    }else{

      if(phoneNumber.length == 8){
        return hasOperatorsPrefixesCI(phoneNumber);
      }else{
        return false;
      }

    }

  }

  static bool hasOperatorsPrefixesCI(String number){

   if(number.length == 8){
     String prefixMobile = number.substring(0, number.length - 6);
     String prefixFix = number.substring(0, number.length - 5);
     print("PREFIX_MOBILE $prefixMobile");
     print("PREFIX_FIX $prefixFix");
     return mobilePrefixesCI.contains(prefixMobile) || fixedLineOperatorsPrefixesCI.contains(prefixFix);
   }

   if(number.length == 10){
     String prefix = number.substring(0, number.length - 8);
     print("PREFIX_MOBILE $prefix");
     return ["01","05", "07", "21", "25", "27"].contains(prefix);
   }

   return false;

  }

  static String getOperatorPrefix(String number){

    if(number.length == 8){
      String prefixMobile = number.substring(0, number.length - 6);
      String prefixFix = number.substring(0, number.length - 5);


      if(mobilePrefixesCI.contains(prefixMobile)){
        print("PREFIX_MOBILE $prefixMobile");
        return prefixMobile;
      }

      if(fixedLineOperatorsPrefixesCI.contains(prefixFix)){
        print("PREFIX_FIX $prefixFix");
        return prefixFix;
      }
      return null;
    }

    if(number.length == 10){
      String prefix = number.substring(0, number.length - 8);
      String prefixFix = number.substring(0, number.length - 8);
      print("PREFIX_PNN $prefix");

      if(["01","05", "07"].contains(prefix)){
        return prefix;
      }

      if(["21", "25", "27"].contains(prefixFix)){
        return prefixFix;
      }

      return null;
    }

    return null;

  }

  static bool isMobile(String number){
    if(number.length == 8){
      String prefixMobile = number.substring(0, number.length - 6);
      print("PREFIX_MOBILE $prefixMobile");
      return mobilePrefixesCI.contains(prefixMobile);
    }

    if(number.length == 10){
      String prefix = number.substring(0, number.length - 8);
      return ["01","05", "07"].contains(prefix);
    }

    return false;

  }

  static bool isFixedLine(String number){

    if(number.length == 8){
      String prefixFix = number.substring(0, number.length - 5);
      return fixedLineOperatorsPrefixesCI.contains(prefixFix);
    }

    if(number.length == 10){
      String prefix = number.substring(0, number.length - 8);
      return ["21", "25", "27"].contains(prefix);
    }

    return false;

  }

  static bool isValidNumber(String phoneNumber){

   return isIvorianNumber(phoneNumber);

  }

  static Future convertPhone(Contact contact) async {

    //print("Contact >>>> ${contact.toJson()}");

    //final String isoCode  = COUNTRY_ISO;
    final List<Phone> phones = contact.phones == null ? [] : contact.phones.toList();
    final List<Phone> newPhones = [];


    for(Phone phone in phones){

      print("Phone >>> $phone");
      print("Phone.normalizedNumber >>> ${IvoryCostPhoneUtil.normalizePhoneNumber(phone.number)}");

      bool isValid = isValidPhone(phone);

      if(!isValid){

        newPhones.add(phone);
        continue;
      }

      if(IvoryCostPhoneUtil.isConverted(phone)){
        newPhones.add(phone);
        continue;
      }


      // When it is valid phone
      String simpleNumber = IvoryCostPhoneUtil.simpleNumber(phone.number);
      // RegionInfo regionInfo = await PhoneNumberUtil.getRegionInfo(phoneNumber: phone.normalizedNumber, isoCode: COUNTRY_ISO);

      String operator = IvoryCostPhoneUtil.operatorByPhoneNumber(simpleNumber);

      bool isMobile = IvoryCostPhoneUtil.isMobile(simpleNumber);
      bool isFixedLine = IvoryCostPhoneUtil.isFixedLine(simpleNumber);

      operator = operator.toLowerCase();

      if(IvoryCostPhoneUtil.operators.contains(operator)){
        String phoneNumber = simpleNumber;

        String operatorPrefix = "";

        if(isMobile){

          operatorPrefix = IvoryCostPhoneUtil.mobileOperators[operator];

        }

        if(isFixedLine){
          operatorPrefix = IvoryCostPhoneUtil.fixedLineOperators[operator];
        }

        print(" $operatorPrefix");
        if(operatorPrefix != null){
          String newPhoneNumber = "+225 "+operatorPrefix+" "+phoneNumber;
          newPhoneNumber  = await IvoryCostPhoneUtil.normalizePhoneNumber(newPhoneNumber);

          Phone newPhone = new Phone(newPhoneNumber,
              normalizedNumber: newPhoneNumber,
              customLabel: "PNN"
          );

          newPhones.add(newPhone);
          if(!newPhones.contains(phone)){
            newPhones.add(phone);
          }

        }



      }

    }

    contact.phones = newPhones;

    await FlutterContacts.updateContact(contact);

    print("Converted");


  }

  static bool isValidPhone(Phone phone) {

    return IvoryCostPhoneUtil.isValidNumber(phone.number);

  }



}