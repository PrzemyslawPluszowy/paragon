import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/documents/pages/documents_screen.dart';
import 'package:rcp_new/Features/setting/pages/setting_screen.dart';
import 'package:rcp_new/shared/global_widget/responsive_widget.dart';

import '../../choise_mode_screen/pages/choice_mode_screen.dart';
import '../cubit/mainscreen_cubit.dart';

List<Widget> _widgetOptions = <Widget>[
  const AddRecipeScreen(),
  const DocumentsScreen(),
  const SettingScreen(),
];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(phone: MainPhoneScreen());
  }
}

class MainPhoneScreen extends StatelessWidget {
  const MainPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainscreenCubit, MainscreenState>(
      builder: (context, state) {
        return Scaffold(
            body: _widgetOptions.elementAt(state.currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<MainscreenCubit>().changePage(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.document_scanner), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.edit_document), label: 'Documents'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ));
      },
    );
  }
}
