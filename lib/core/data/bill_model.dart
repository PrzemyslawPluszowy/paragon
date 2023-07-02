import 'package:cloud_firestore/cloud_firestore.dart';

enum DocumentType { bill, document }

class DocumentModel {
  DocumentModel({
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
    this.type,
  });
  final String? type;
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
      'dateCreated': dateCreated,
      'listItems': listItems,
      'price': price,
      'imagePath': imagePath,
      'companyName': companyName,
      'categoryList': category,
      'type': type,
    };
  }

  factory DocumentModel.fromSnapshot(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return DocumentModel(
      name: json['name'],
      userId: json['id'],
      dateCreated: json['dateCreated'],
      listItems: List.from(json['listItems']),
      price: json['price'],
      imagePath: json['imagePath'],
      companyName: json['companyName'],
      category: json['category'],
      guaranteeDate: json['guaranteeDate'],
      billId: json['billId'],
      type: json['type'],
    );
  }
}
