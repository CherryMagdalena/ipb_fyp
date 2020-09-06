import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/bottom_app_bar.dart';
import 'package:ipb_fyp/components/rounded_clipper.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:ipb_fyp/resources/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contactList = [];
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  final String kNameKey = 'Contact Name';
  final String kPhoneKey = 'Contact Number';

  _addContact() {
    ContactPicker().selectContact().then((value) {
      setState(() {
        bool isSimilar = false;
        for (Contact contact in contactList) {
          isSimilar = contact.fullName == value.fullName;
          if (isSimilar) {
            break;
          }
        }
        if (!isSimilar) {
          //Maximum 5 contacts
          if (contactList.length < 5) {
            contactList.add(value);
            _addToSharedPreferences(value, contactList.length - 1);
          }
        }
      });
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

  void _retrieveFromSharedPreferences() async {
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
    }
    setState(() {
      contactList = contacts;
    });
  }

  _emptySharedPreferences() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    setState(() {
      sharedPreferences.clear();
    });
  }

  _removeContact(int index) async {
    contactList.remove(contactList[index]);
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.clear();
    for (int i = 0; i <= contactList.length; i++) {
      _addToSharedPreferences(contactList[i], i);
    }
    print(sharedPreferences.getKeys());
  }

  _checkSharedPreferences() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    print(sharedPreferences.getKeys());
  }

  @override
  void initState() {
    _retrieveFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
                clipper: RoundedClipper(),
                child: Container(
                  height: 230.0,
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text(
                            'Contact List',
                            style: kHomeScreenTitle,
                          ),
                        ),
                      ]),
                )),
            RaisedButton(
              color: kSecondaryColor,
              onPressed: _addContact,
              child: Text('Add Contact'),
            ),
            RaisedButton(
              child: Text('Check shared preferences'),
              onPressed: () {
                _checkSharedPreferences();
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Container(
                width: 300.0,
                child: contactList.length == 0
                    ? Text(
                        'No contact added',
                        style: kSelectedTextStyle,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ContactCard(
                              contactList[index],
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _removeContact(index);
                                  });
                                },
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15.0,
                          );
                        },
                        itemCount: contactList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  final IconButton trailingButton;
  ContactCard(this.contact, this.trailingButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      height: 75.0,
      child: ListTile(
        title: Text(
          contact.fullName,
          style: kSelectedTextStyle,
        ),
        subtitle: contact.phoneNumber == null
            ? Text(' ')
            : Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  contact.phoneNumber.number,
                  style: kSelectedTextStyle,
                ),
              ),
        trailing: trailingButton,
      ),
    );
  }
}
