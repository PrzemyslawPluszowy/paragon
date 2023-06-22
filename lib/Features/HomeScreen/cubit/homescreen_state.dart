part of 'homescreen_cubit.dart';

class HomeScreenState extends Equatable {
  const HomeScreenState(
      {required this.filePath, required this.isCameraGranted});
  final String? filePath;
  final bool isCameraGranted;

  factory HomeScreenState.initail() {
    return const HomeScreenState(
      filePath: null,
      isCameraGranted: false,
    );
  }
  HomeScreenState copyWith(
      {required String? filePath, required bool? isCameraGranted}) {
    return HomeScreenState(
      filePath: filePath,
      isCameraGranted: isCameraGranted ?? this.isCameraGranted,
    );
  }

  @override
  List<Object?> get props => [filePath, isCameraGranted];
}
