import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/Auth/presentation/cubit/login_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreen'),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              context.read<LoginCubit>().logOut();
            },
            child: const Text('data')),
      ),
    );
  }
}
