import 'package:contact_picker/contact_picker.dart';
import 'package:ipb_fyp/model/contact_list.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms/sms.dart';

class SMSBroadcast {
  static Future<List<String>> _getRecipients() async {
    await ContactList().retrieveContactList();
    print('getRecipients');
    List<Contact> contacts = ContactList.contactList ?? [];
    List<String> contactNumbers = [];
    contacts.forEach((element) {
      contactNumbers.add(element.phoneNumber.number);
    });
    return contactNumbers;
  }

  Future<String> openSMSRoom() async {
    final List<String> recipientsPhoneNumber = await _getRecipients();
    print('recipients:');
    print(recipientsPhoneNumber);
    String _result =
        await sendSMS(message: ' ', recipients: recipientsPhoneNumber)
            .catchError((onError) {
      print(onError);
    });
    return _result;
  }

  Future<bool> broadcastSMS(String message) async {
    SmsSender smsSender = SmsSender();
    List<String> recipientList = await _getRecipients();
    for (String recipient in recipientList) {
      SmsMessage smsMessage = SmsMessage(recipient, message);
      smsSender.sendSms(smsMessage);
      smsMessage.onStateChanged.listen((state) {
        if (state == SmsMessageState.Fail) {
          return false;
        }
      });
    }
    return true;
  }

  broadcastLinkSMS(String userId){
    String link = 'example.com';
    String message = 'Hello, I request your assistance in monitoring my location.\nPlease go to $link and enter the following:'
        '\nUser ID: $userId';
  }
}
