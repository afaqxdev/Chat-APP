// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';

import 'package:chat_app/core/models/chat_model.dart';
import 'package:chat_app/feature/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/loadind_dailog.dart';

class Api {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get users => auth.currentUser!;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late ModelChat profileData;

  static Future<UserCredential> signInWithGoogle(BuildContext context) async {
    CommonDialog.showDialogs(context);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      CommonDialog.hideLoading();
      CommonDialog.showFailedSnackbar(error: e.toString());

      throw Exception(e.toString());
    }
    // Once signed in, return the UserCredential
  }

  static Future<bool> userExist() async {
    return (await firestore.collection('chating').doc(users.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final chat = ModelChat(
      id: users.uid,
      name: users.displayName,
      email: users.email,
      about: "hi my name is ${users.displayName}",
      createdAt: '',
      isOnline: false,
      image: users.photoURL,
      lastActive: '',
      pushToken: '',
    );
    await firestore.collection('chating').doc(users.uid).set(chat.toJson());
  }

  static checkingUser(BuildContext context) {
    signInWithGoogle(context).then((value) async {
      if (value != null) {
        log("${value.user}");
        log("${value.additionalUserInfo}");
        if ((await userExist())) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const  HomeScreen();
            },
          ));
        } else {
          createUser().then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const  HomeScreen();
              },
            ));
          });
        }
      }
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUser() {
    return firestore
        .collection('chating')
        .where('id', isNotEqualTo: users.uid)
        .snapshots();
  }

  static Future<void> getProfileData() async {
    await firestore
        .collection('chating')
        .doc(users.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        profileData = ModelChat.fromJson(user.data()!);
      } else {
        await createUser().then((value) {
          getProfileData();
        });
      }
    });
  }
    static Future<void> upDateData() async {
    
    await firestore.collection('chating').doc(users.uid).update({
 'name':profileData.name,
 'about':profileData.about
    });
  }
}
