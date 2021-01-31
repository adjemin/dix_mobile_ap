import 'package:dixapp/models/BackupResult.dart';
import 'package:dixapp/util/FlutterContacts.dart';

import 'LoginManager.dart';
import 'dixcontact.dart';

class Restore {


  static rest()async {

    BackupResult backupResult = await LoginManager.loadBackupContacts();
    final List<DixContact> contacts = backupResult.backup;
    print("BackupResult >>>>> $contacts");

    await FlutterContacts.saveContacts(contacts);

  }

}