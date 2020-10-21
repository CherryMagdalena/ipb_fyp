import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/bottom_app_bar.dart';
import 'package:ipb_fyp/components/page_header.dart';
import 'package:ipb_fyp/model/contact_list.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:ipb_fyp/resources/text_style.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contactList = [];
  @override
  void initState() {
    //Set State
    _retrieveContacts();
    super.initState();
  }

  void _retrieveContacts() async {
    await ContactList().retrieveContactList();
    setState(() {
      contactList = ContactList.contactList;
    });
  }

  void _addContact() async {
    await ContactList().addContact();
    setState(() {
      contactList = ContactList.contactList;
    });
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
            PageHeader('Contact List'),
            RaisedButton(
              color: kSecondaryColor,
              onPressed: () {
                _addContact();
              },
              child: Text('Add Contact'),
            ),
            RaisedButton(
              child: Text('Check sp'),
              onPressed: () {
                ContactList().checkSharedPreferences();
              },
            ),
            RaisedButton(
              child: Text('Clear sp'),
              onPressed: () {
                ContactList().clearSharedPreferences();
                contactList.clear();
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
                                    ContactList().removeContact(index);
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
