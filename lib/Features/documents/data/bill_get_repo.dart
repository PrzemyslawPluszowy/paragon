import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/data/bill_model.dart';

abstract class BillGetRepo {
  Future<List<DocumentModel>> getBills(String sortQuery, bool descending);
  Future<void> deleteBill({required String billId});
  Future<void> deleteImage({required String billid});
  Future<List<DocumentModel>> getAlldocuments();
  void refreshDocument();
}

class BillGetRepoImpl implements BillGetRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  BillGetRepoImpl(
      {required this.firebaseStorage, required this.firebaseFirestore});

  DocumentSnapshot? _lastVisible;
  @override
  Future<List<DocumentModel>> getBills(
      String sortQuery, bool descending) async {
    List<DocumentModel> bills = [];
    Query<Map<String, dynamic>>? showPage;
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      showPage = firebaseFirestore
          .collection('bills')
          .where('id', isEqualTo: userId)
          .orderBy(sortQuery, descending: descending)
          .limit(10);
      if (_lastVisible != null) {
        showPage = showPage.startAfterDocument(_lastVisible!);
      }

      QuerySnapshot querySnapshot = await showPage.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastVisible = querySnapshot.docs.last;
      }
      for (var element in querySnapshot.docs) {
        bills.add(DocumentModel.fromSnapshot(element));
      }
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
    return bills;
  }

  @override
  Future<void> deleteBill({required String billId}) async {
    try {
      await firebaseFirestore.collection('bills').doc(billId).delete();
      await deleteImage(billid: billId);
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
  void refreshDocument() {
    _lastVisible = null;
  }

  @override
  Future<void> deleteImage({required String billid}) async {
    try {
      final ref = firebaseStorage.ref().child('bills').child('$billid.jpg');
      await ref.delete();
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 10,
      );
    }
  }

  @override
  Future<List<DocumentModel>> getAlldocuments() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = firebaseFirestore
          .collection('bills')
          .where('id', isEqualTo: userId)
          .orderBy('dateCreated', descending: true);
      final snapshot = await ref.get();
      return snapshot.docs.map((e) => DocumentModel.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
