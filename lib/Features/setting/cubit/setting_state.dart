part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState({required this.isBusyl, required this.status});
  final bool isBusyl;
  final String status;

  factory SettingState.initail() {
    return const SettingState(isBusyl: false, status: '');
  }
  copyWith({bool? isBusyl, String? status}) {
    return SettingState(
        isBusyl: isBusyl ?? this.isBusyl, status: status ?? this.status);
  }

  @override
  List<Object> get props => [isBusyl, status];
}
