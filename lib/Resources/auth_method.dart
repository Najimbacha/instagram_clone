import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthMetod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    // required Uint8List file,
  }) async {
    String res = "Some Error occure";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //create user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        //database

        await _firestore.collection('users').doc(cred.user!.uid).set(
          {
            'Username': username,
            'Uid': cred.user!.uid,
            'Email': email,
            'Bio': bio,
            'Follower': [],
            'Following': [],
          },
        );
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
