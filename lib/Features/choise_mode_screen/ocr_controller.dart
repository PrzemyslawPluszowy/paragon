import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:rcp_new/core/data/company_data.dart';
import 'package:rcp_new/core/data/model/company_model.dart';

abstract class OcrController {
  Future<List<String>> convertingImegetoText(String filePath);
  List<String>? getListPrice(List<String> text);
  DateTime? getDateFromRecipe(List<String> text);
  CompanyModel? getCompanyName(List<String> text);
  List<String>? getListItem(List<String> text);
  List<String> getCategoryList();
  List<String>? getStringHelper(List<String> text);
}

class OcrControllerImpl implements OcrController {
  @override
  Future<List<String>> convertingImegetoText(String filePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    InputImage inputImage = InputImage.fromFilePath(filePath);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    List<String> textList = recognizedText.blocks.map((e) => e.text).toList();
    return textList;
  }

  @override
  List<String>? getListPrice(List<String> textList) {
    final List<String> splitedList = [];
    final List<String> finalList = [];

//serach for price
    textList
        .where((element) => element.contains(
            RegExp(r'(?<!\d)(\d{1,3}(?:[., ]\d{3})*(?:[.,]\d{2}))(?!\d)')))
        .toList();
//split 'spaces' and 'new line'
    for (var element in textList) {
      splitedList.addAll(element.split(' '));
    }
//split non digit
    RegExp regExp = RegExp(r'^\d{1,3}(?:[.,]\d{2})?$');
    splitedList.removeWhere((element) => !regExp.hasMatch(element));
//replace ',' to '.'
    for (var element in splitedList) {
      finalList.add(element.replaceAll(',', '.'));
    }
//sort
    finalList.sort((b, a) => double.parse(a).compareTo(double.parse(b)));
    return finalList.isNotEmpty ? finalList : null;
  }

  @override
  DateTime? getDateFromRecipe(List<String> textList) {
    String allString = textList.join(' ');

    final regexDate = RegExp(r'\d{4}-\d{2}-\d{2}');
    final match = regexDate.firstMatch(allString);
    if (match != null) {
      String? dateString = match[0];
      return DateTime.parse(dateString!);
    } else {
      return null;
    }
  }

  @override
  CompanyModel? getCompanyName(List<String> text) {
    final List<String> preparedList = [];
    for (var element in text) {
      preparedList.addAll(
          element.toLowerCase().replaceAll(RegExp(r'[-,]'), ' ').split(' '));
    }
    String textTo = preparedList.join(' ');
    int? index;
    index = companyList.indexWhere((company) {
      return (textTo.toLowerCase().contains(company['key']!.toLowerCase()));
    });
    if (index == -1) {
      return null;
    } else {
      CompanyModel company = CompanyModel.fromJson(companyList[index]);
      return company;
    }
  }

  @override
  List<String>? getListItem(List<String> text) {
    RegExp regexStart = RegExp(r'fiska', caseSensitive: false);
    RegExp regexStart2 = RegExp(r'paragon', caseSensitive: false);

    RegExp regexEnd = RegExp(r'sprz', caseSensitive: false);
    int startIndex = text
        .indexWhere((element) => regexStart.hasMatch(element.toLowerCase()));
    if (startIndex == -1) {
      startIndex = text
          .indexWhere((element) => regexStart2.hasMatch(element.toLowerCase()));
    }
    int endIndex =
        text.indexWhere((element) => regexEnd.hasMatch(element.toLowerCase()));
    debugPrint('start: $startIndex, end: $endIndex');
    if (startIndex != -1 && endIndex != -1 && startIndex < endIndex - 1) {
      List<String> sublistList = text.sublist(startIndex + 1, endIndex - 1);
      List<String> finalList = [];
      for (var element in sublistList) {
        finalList.add(element.replaceAll(
            RegExp(r'\b(\d+|\b\w{1,2}\b|\b\w*\d\w{0,3}\b|\,|\.)\b',
                caseSensitive: false),
            ''));
      }
      finalList.removeWhere((element) => element.isEmpty);
      return finalList;
    } else {
      return null;
    }
  }

  @override
  List<String> getCategoryList() {
    return companyList.map((e) => e['category'] as String).toSet().toList();
  }

  @override
  List<String>? getStringHelper(List<String> text) {
    List<String> finalList = [];
    List<String> preparedList = [];
    for (var element in text) {
      element.replaceAll(',', ' ');
      element.replaceAll('.', ' ');
      element.toLowerCase();
      element.replaceAll(RegExp(r'[,.\/\*]+'), '');
    }
    for (var element in text) {
      finalList.add(element.replaceAll(
          RegExp(r'\b(?:\d+|\w*[.,/*]\w*|\w{1,4})\b|[.,/*]',
              caseSensitive: false),
          ''));
    }

    for (var element in finalList) {
      preparedList.addAll(element.toLowerCase().split(' '));
    }

    preparedList.removeWhere((element) => element.length <= 4);
    if (preparedList.length > 21) {
      preparedList = preparedList.sublist(0, 20);
    }
    return finalList;
  }
}
