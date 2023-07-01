import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  BillModel({
    this.name,
    this.billId,
    this.guaranteeDate,
    this.userId,
    this.dateCreated,
    this.listItems,
    this.price,
    this.imagePath,
    this.companyName,
    this.category,
  });
  final String? name;
  final String? billId;
  final String? userId;
  final Timestamp? dateCreated;
  final List<String>? listItems;
  final double? price;
  final String? imagePath;
  final String? companyName;
  final String? category;
  Timestamp? guaranteeDate;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': userId,
      'billId': billId,
      'guaranteeDate': guaranteeDate,
      'date': dateCreated,
      'listItems': listItems,
      'listPrice': price,
      'imagePath': imagePath,
      'companyName': companyName,
      'categoryList': category,
    };
  }

  factory BillModel.fromSnapshot(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return BillModel(
      name: json['name'] as String,
      userId: json['id'] as String,
      dateCreated: json['dateCreated'] as Timestamp,
      listItems: json['listItems'] as List<String>,
      price: json['price'] as double,
      imagePath: json['imagePath'] as String,
      companyName: json['companyName'] as String,
      category: json['category'] as String,
      guaranteeDate: json['guaranteeDate'],
      billId: json['billId'] as String,
    );
  }
}
