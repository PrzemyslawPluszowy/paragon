import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../../../core/data/bill_model.dart';
import '../cubit/documets_screen_cubit.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
    required ScrollController scrollController,
    required this.documents,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<DocumentModel> documents;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
      builder: (context, state) {
        if (documents.isEmpty && state.isLoading == false) {
          return const Center(child: Text('Brak dokumentów'));
        }

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            shrinkWrap: true,
            itemCount:
                state.isLoading ? documents.length + 1 : documents.length,
            itemBuilder: (context, index) {
              if (index == documents.length && state.isLoading == true) {
                return const LinearProgressIndicator();
              }
              return Dismissible(
                background: Container(
                  color: Colors.green,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                key: Key(documents[index].billId!),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    _dismisDialog(context, index);
                  }
                  if (direction == DismissDirection.startToEnd) {
                    context.go('/bill',
                        extra: DocumentModel(
                          billId: documents[index].billId,
                          name: documents[index].name,
                          dateCreated: documents[index].dateCreated,
                          guaranteeDate: documents[index].guaranteeDate,
                          type: documents[index].type,
                          category: documents[index].category,
                          companyName: documents[index].companyName,
                          listItems: documents[index].listItems,
                          price: documents[index].price,
                          userId: documents[index].userId,
                          imagePath: documents[index].imagePath,
                        ));
                  }
                  return null;
                },
                child: ListTile(
                  tileColor: index.isEven ? Colors.grey[300] : Colors.white,
                  leading: documents[index].type == 'bill'
                      ? const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.receipt_long,
                              color: FigmaColorsAuth.darkFiolet),
                        )
                      : const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.description,
                              color: FigmaColorsAuth.darkFiolet),
                        ),
                  title: Text(
                    'Nazwa: ${documents[index].name}',
                    style: const TextStyle(
                      color: FigmaColorsAuth.darkFiolet,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: documents[index].dateCreated != null
                              ? 'Data dodania: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(state.bills[index].dateCreated!.millisecondsSinceEpoch))}'
                              : 'brak',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: documents[index].guaranteeDate != null &&
                                  documents[index]
                                          .guaranteeDate!
                                          .millisecondsSinceEpoch >
                                      DateTime.now().millisecondsSinceEpoch
                              ? 'Koniec gwarancji: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(state.bills[index].guaranteeDate!.millisecondsSinceEpoch))}'
                              : 'Brak gwarancji',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Text('${documents[index].price.toString()} PLN'),
                ),
              );
            },
          );
        }
      },
    );
  }

  _dismisDialog(BuildContext context, int index) async {
    await showDialog(
        context: context,
        builder: (context) =>
            BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
              builder: (context, state) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AlertDialog(
                    title: const Text('Czy napewno chcesz usunąc?'),
                    actions: state.isLoading
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LinearProgressIndicator(),
                            )
                          ]
                        : [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Nie'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await context
                                    .read<DocumetsScreenCubit>()
                                    .deleteDocument(
                                        id: documents[index].billId!);
                                if (context.mounted &&
                                    state.isLoading == false) {
                                  context.pop();
                                }
                              },
                              child: const Text('Tak'),
                            ),
                          ],
                  ),
                );
              },
            ));
  }
}
