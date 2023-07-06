import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension ToMonthNumber on Timestamp {
  double toMonthhNumber() {
    return double.parse(Jiffy.parseFromDateTime(toDateTimeFromTimestep())
        .diff(Jiffy.now(), unit: Unit.month)
        .toString());
  }
}

extension TimestampToDate on Timestamp {
  DateTime toDateTimeFromTimestep() {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }
}

extension ToDate on Timestamp {
  String dateToStringFromTimestep() {
    return DateFormat('dd-MM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch));
  }
}
