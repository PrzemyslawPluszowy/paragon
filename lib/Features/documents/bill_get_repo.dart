import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/data/bill_model.dart';

abstract class BillGetRepo {
  Future<List<BillModel>> getBills({String sortQuery = 'dateCreated'});
}

class BillGetRepoImpl implements BillGetRepo {
  final FirebaseFirestore firebaseFirestore;

  BillGetRepoImpl({required this.firebaseFirestore});

  DocumentSnapshot? _lastVisible;
  @override
  Future<List<BillModel>> getBills({String sortQuery = 'dateCreated'}) async {
    List<BillModel> bills = [];
    Query<Map<String, dynamic>>? showPage;
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      showPage = firebaseFirestore
          .collection('bills')
          .where('id', isEqualTo: userId)
          .orderBy(sortQuery, descending: true)
          .limit(10);
      if (_lastVisible != null) {
        showPage = showPage.startAfterDocument(_lastVisible!);
      }

      QuerySnapshot querySnapshot = await showPage.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastVisible = querySnapshot.docs.last;
      }
      for (var element in querySnapshot.docs) {
        bills.add(BillModel.fromSnapshot(element));
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
}
