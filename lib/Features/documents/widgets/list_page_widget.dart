import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rcp_new/core/theme/theme.dart';
import 'package:rcp_new/core/utils/extension.dart';

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
      }
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: false,
        itemCount: state.loadingMoreData || state.isLoading || state.isEndOfList
            ? documents.length + 1
            : documents.length,
        itemBuilder: (context, index) {
          if (index == documents.length && state.loadingMoreData) {
            return const LinearProgressIndicator();
          }
          if (index == documents.length && state.isEndOfList) {
            return const Text('To juz wszytsko :)');
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
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: index.isEven
                        ? FigmaColorsAuth.darkFiolet
                        : FigmaColorsAuth.darkFiolet.withOpacity(0.7),
                    width: 70,
                    child: documents[index].guaranteeDate != null
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text(
                                  '${documents[index].guaranteeDate!.toMonthhNumber().round()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: FigmaColorsAuth.white),
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'miesięcy',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: FigmaColorsAuth.white),
                                  softWrap: true,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'gwarancji',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: FigmaColorsAuth.white),
                                  softWrap: true,
                                ),
                              ]))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'brak',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: FigmaColorsAuth.white),
                                  softWrap: true,
                                ),
                              ]),
                  ),
                  Flexible(
                    child: ListTile(
                      onTap: () {
                        context.push('/bill-detail', extra: documents[index]);
                      },
                      contentPadding: const EdgeInsets.all(8),
                      tileColor:
                          index.isEven ? Colors.grey[700] : Colors.grey[400],
                      title: RichText(
                        text: TextSpan(
                            text: 'Nazwa: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: documents[index].name,
                                style: const TextStyle(
                                  color: FigmaColorsAuth.darknessFiolet,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: documents[index].dateCreated != null
                                    ? 'Data dodania: '
                                    : 'brak',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: documents[index].dateCreated != null
                                        ? DateFormat('dd-MM-yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                state.bills[index].dateCreated!
                                                    .millisecondsSinceEpoch))
                                        : 'brak',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: documents[index].guaranteeDate == null
                                    ? 'Brak gwarancji'
                                    : documents[index]
                                                .guaranteeDate!
                                                .millisecondsSinceEpoch >
                                            DateTime.now()
                                                .millisecondsSinceEpoch
                                        ? 'Koniec gwarancji: '
                                        : 'Zakończono gwarancję: ${documents[index].guaranteeDate!.dateToStringFromTimestep()} ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: documents[index].guaranteeDate !=
                                                null &&
                                            documents[index]
                                                    .guaranteeDate!
                                                    .millisecondsSinceEpoch >
                                                DateTime.now()
                                                    .millisecondsSinceEpoch
                                        ? DateFormat('dd-MM-yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                documents[index]
                                                    .guaranteeDate!
                                                    .millisecondsSinceEpoch))
                                        : '  ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      trailing:
                          Text('${documents[index].price.toString()} PLN'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
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
                              onPressed: () {
                                context
                                    .read<DocumetsScreenCubit>()
                                    .deleteDocument(
                                        id: documents[index].billId!);

                                if (!state.isLoading) {
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
