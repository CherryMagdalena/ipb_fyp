import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<bool> register(
      {@required String email, @required String password}) async {
    bool result;
    final User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      result = true;
      await _database
          .collection('users')
          .add({'email': user.email, 'latitude': '', 'longitude': ''});
    }
    return result;
  }

  Future<bool> logIn(
      {@required String email, @required String password}) async {
    final User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    bool result = (user != null);
    return result;
  }

  void logOut() async {
    await _auth.signOut();
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<String> getDocumentId() async {
    User user = _auth.currentUser;
    QuerySnapshot documents = await _database
        .collection('users')
        .where('email', isEqualTo: user.email.toString())
        .get();
    String documentId = documents.docs.first.id;
    return documentId;
  }

  void updateLocation(Position position) async {
    String documentId = await getDocumentId();
    DocumentReference userDocument =
        _database.collection('users').doc(documentId);
    print(userDocument.toString());
    _database.collection('users').doc(documentId).update(
        {'latitude': position.latitude, 'longitude': position.longitude});
  }
}
