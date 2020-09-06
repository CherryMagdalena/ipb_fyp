import 'package:contact_picker/contact_picker.dart';
import 'package:ipb_fyp/model/contact_list.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SMSBroadcast {
  static List<String> _getRecipients() {
    print('getRecipients');
    List<Contact> contacts = ContactList.contactList ?? [];
    List<String> contactNumbers = [];
    contacts.forEach((element) {
      contactNumbers.add(element.phoneNumber.number);
    });
    return contactNumbers;
  }

  Future<String> broadcastSMS() async {
    await ContactList().retrieveContactList();
    final List<String> recipientsPhoneNumber = _getRecipients();
    print('recipients:');
    print(recipientsPhoneNumber);
    String _result =
        await sendSMS(message: ' ', recipients: recipientsPhoneNumber)
            .catchError((onError) {
      print(onError);
    });
    return _result;
  }
}
