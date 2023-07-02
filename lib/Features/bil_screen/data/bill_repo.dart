import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../../../core/data/bill_model.dart';

abstract class BillRepo {
  Future saveBill({required DocumentModel bill});
  Future saveBilImage({required String path, required String billId});
}

class BillRepoImpl implements BillRepo {
  BillRepoImpl({
    required this.firebaseStorage,
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  @override
  Future saveBill({required DocumentModel bill}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final billId = bill.billId ?? const Uuid().v1();
      if (bill.imagePath != null) {
        String filePath =
            await saveBilImage(path: bill.imagePath!, billId: billId);
        DocumentModel newBill = DocumentModel(
            guaranteeDate: bill.guaranteeDate,
            name: bill.name,
            billId: billId,
            userId: userId,
            dateCreated: bill.dateCreated,
            listItems: bill.listItems,
            price: bill.price,
            imagePath: filePath,
            companyName: bill.companyName,
            category: bill.category);
        await firebaseFirestore.collection('bills').doc(billId).set(
              newBill.toJson(),
            );
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong, with image upload');
      }
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
  //TODO: add try catch

  @override
  Future<String> saveBilImage(
      {required String path, required String billId}) async {
    String url = '';
    try {
      final fileToUpload = File(path);
      final ref = firebaseStorage.ref().child('bills').child(billId);
      await ref.putFile(fileToUpload);
      url = await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return url;
  }
}
