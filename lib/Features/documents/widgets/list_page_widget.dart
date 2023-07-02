import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/data/bill_model.dart';
import '../cubit/documets_screen_cubit.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
    required ScrollController scrollController,
    required this.bills,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<BillModel> bills;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
      builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.isLoading ? bills.length + 1 : bills.length,
          itemBuilder: (context, index) {
            if (index == bills.length && state.isLoading == true) {
              return const LinearProgressIndicator();
            }
            return ListTile(
              tileColor: index.isEven ? Colors.grey[300] : Colors.white,
              leading: bills[index].imagePath != null
                  ? Image.network(bills[index].imagePath!)
                  : const Icon(Icons.image_not_supported),
              title: Text(bills[index].name ?? 'brak'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: bills[index].dateCreated != null
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
                      text: bills[index].guaranteeDate != null
                          ? 'Koniec gwarancji: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(state.bills[index].guaranteeDate!.millisecondsSinceEpoch))}'
                          : 'brak gwarancji',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
