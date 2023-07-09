class DocumetsToPdfModel {
  DocumetsToPdfModel({
    required this.guaranteeDate,
    required this.name,
    required this.dateCreated,
    required this.listItems,
    required this.price,
    required this.imageProvider,
    required this.companyName,
    required this.category,
  });

  final String name;
  final String dateCreated;
  final List<String> listItems;
  final double? price;
  final dynamic imageProvider;
  final String companyName;
  final String category;
  final String guaranteeDate;

  DocumetsToPdfModel copyWith({
    String? guaranteeDate,
    String? name,
    String? dateCreated,
    List<String>? listItems,
    double? price,
    dynamic imageProvider,
    String? companyName,
    String? category,
  }) {
    return DocumetsToPdfModel(
      guaranteeDate: guaranteeDate ?? this.guaranteeDate,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
      listItems: listItems ?? this.listItems,
      price: price ?? this.price,
      imageProvider: imageProvider ?? this.imageProvider,
      companyName: companyName ?? this.companyName,
      category: category ?? this.category,
    );
  }
}
