import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("users");
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> getData() async {
    return collection.doc(user!.uid).get();
  }
}
