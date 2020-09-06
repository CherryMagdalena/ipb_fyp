import 'package:contact_picker/contact_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactList {
  static List<Contact> contactList = [];

  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  final String kNameKey = 'Contact Name';
  final String kPhoneKey = 'Contact Number';

  static int getLength() {
    return contactList.length;
  }

  addContact() async {
    print('add Contact');
    await ContactPicker().selectContact().then((value) {
      print(value.fullName);
      bool isSimilar = false;
      for (Contact contact in contactList) {
        print('in loop');
        isSimilar = contact.fullName == value.fullName;
        if (isSimilar) {
          break;
        }
      }
      if (!isSimilar) {
        print('not Similar');
        //Maximum 5 contacts
        if (contactList.length < 5) {
          contactList.add(value);
          _addToSharedPreferences(value, contactList.length - 1);
        }
      }
    });
  }

  _addToSharedPreferences(Contact value, int index) async {
    print('store');
    SharedPreferences sharedPreferences = await _sharedPreferences;
    String nameKey = kNameKey + index.toString();
    String phoneKey = kPhoneKey + index.toString();
    await sharedPreferences.setString(nameKey, value.fullName);
    await sharedPreferences.setString(phoneKey, value.phoneNumber.number);
  }

  void retrieveContactList() async {
    print('retrieve');
    SharedPreferences sharedPreferences = await _sharedPreferences;
    int entries = sharedPreferences.getKeys().length;
    List<Contact> contacts = [];
    if (entries != 0) {
      //Entries includes name and phone number, therefore divide by 2 to get the amount of contacts
      entries = (entries / 2).round();
      for (int i = 0; i < entries; i++) {
        String name = sharedPreferences.getString(kNameKey + i.toString());
        PhoneNumber phone = PhoneNumber(
            number: sharedPreferences.getString(kPhoneKey + i.toString()),
            label: '');
        contacts.add(Contact(fullName: name, phoneNumber: phone));
      }
      contactList = contacts;
    }
  }

  removeContact(int index) async {
    contactList.remove(contactList[index]);
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.clear();
    for (int i = 0; i <= contactList.length; i++) {
      _addToSharedPreferences(contactList[i], i);
    }
    print(sharedPreferences.getKeys());
  }

  checkSharedPreferences() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    print(sharedPreferences.getKeys());
    print('contactList:');
    print(contactList);
  }

  clearSharedPreferences() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.clear();
    contactList.clear();
  }
}
