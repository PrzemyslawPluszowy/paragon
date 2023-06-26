part of 'mainscreen_cubit.dart';

class MainscreenState extends Equatable {
  final int currentIndex;

  const MainscreenState({required this.currentIndex});
  @override
  List<Object> get props => [currentIndex];
  const MainscreenState.initial() : currentIndex = 0;
  MainscreenState copyWith({int? currentIndex}) {
    return MainscreenState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
