part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState(
      {required this.pdfFile, required this.isBusyl, required this.status});
  final bool isBusyl;
  final String status;
  final File? pdfFile;

  factory SettingState.initail() {
    return const SettingState(isBusyl: false, status: '', pdfFile: null);
  }
  copyWith({bool? isBusyl, String? status, File? pdfFile}) {
    return SettingState(
        isBusyl: isBusyl ?? this.isBusyl,
        status: status ?? this.status,
        pdfFile: pdfFile ?? this.pdfFile);
  }

  @override
  List<Object?> get props => [isBusyl, status, pdfFile];
}
