import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogConfirm {
  static confirmDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required Function onConfirm}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Anuluj')),
            TextButton(
                onPressed: () {
                  onConfirm();

                  context.pop();
                },
                child: const Text('Potwierdź')),
          ],
        );
      },
    );
  }
}
