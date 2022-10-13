import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/Resources/storage_method.dart';

class AuthMetod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
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

        String photourl = await StorageMethod().uploadimagetostorage(
          'profile pic',
          file,
          false,
        );

        //database

        await _firestore.collection('users').doc(cred.user!.uid).set(
          {
            'Username': username,
            'Uid': cred.user!.uid,
            'Email': email,
            'Bio': bio,
            'Follower': [],
            'Following': [],
            'photourl': photourl,
          },
        );
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Badly Formatted";
      } else if (err.code == 'weak-password') {
        res = "weak password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some Error Occured ";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Success";
      } else {
        res = "Please enter email and password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
