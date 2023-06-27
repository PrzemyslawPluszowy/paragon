class CompanyModel {
  final String name;
  final String www;
  final String category;
  final String key;

  CompanyModel(
      {required this.name,
      required this.www,
      required this.category,
      required this.key,
      required String id});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        name: json['name'],
        www: json['www'],
        category: json['category'],
        key: json['key'],
        id: '');
  }

  factory CompanyModel.initial() {
    return CompanyModel(name: '', www: '', category: '', key: '', id: '');
  }
}
