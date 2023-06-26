import 'package:rcp_new/core/data/model/company_model.dart';

class BillModel {
  CompanyModel? companyName;
  DateTime date;
  List<String> listItems;
  List<String> listPrice;
  String imagePath;
  List<String> categoryList;

  BillModel({
    required this.companyName,
    required this.date,
    required this.listItems,
    required this.listPrice,
    required this.imagePath,
    required this.categoryList,
  });
}
