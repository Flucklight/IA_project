import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  late String id;
  late String displayName;
  late String photoURL;
  late String email;
  late DocumentReference reference;

  UserData.set(User? userData, DocumentReference ref) {
    reference = ref;
    id = userData!.uid;
    displayName = userData.displayName!;
    photoURL = userData.photoURL!;
    email = userData.email!;
  }
}
