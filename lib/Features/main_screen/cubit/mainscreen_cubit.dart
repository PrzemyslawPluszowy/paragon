import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'mainscreen_state.dart';

class MainscreenCubit extends Cubit<MainscreenState> {
  MainscreenCubit() : super(const MainscreenState.initial());

  changePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
