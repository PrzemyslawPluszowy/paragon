import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class SettingRepo {
  Future<void> deleteAlldata();
  Future<void> deleteImage({required String billid});
}

class SettingRepoImpl implements SettingRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  SettingRepoImpl(
      {required this.firebaseFirestore,
      required this.firebaseStorage,
      required this.firebaseAuth});
  @override
  Future<void> deleteAlldata() async {
    try {
      await firebaseFirestore
          .collection('bills')
          .where('id', isEqualTo: firebaseAuth.currentUser!.uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          deleteImage(billid: ds.id).then((value) => ds.reference.delete());
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 10,
      );
    }
  }

  @override
  Future<void> deleteImage({required String billid}) async {
    try {
      await firebaseStorage.ref().child('bills').child('$billid.jpg').delete();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 10,
      );
    }
  }
}
