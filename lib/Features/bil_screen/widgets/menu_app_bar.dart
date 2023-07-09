import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/bill_model.dart';
import '../../../core/theme/theme.dart';
import '../../documents/cubit/documets_screen_cubit.dart';
import '../cubit/bill_cubit.dart';

class MenuAppBarWidget extends StatelessWidget {
  final String? imagePath;
  final GlobalKey<FormState> formKey;
  final String? type;
  final String category;
  final String companyName;
  final DateTime dateCreated;
  final DateTime? guaranteeDate;
  final List<String> listItems;
  final String name;
  final double price;
  final String? userId;
  final String? id;

  const MenuAppBarWidget(
      {super.key,
      this.imagePath,
      required this.formKey,
      this.type,
      required this.category,
      required this.companyName,
      required this.dateCreated,
      this.guaranteeDate,
      required this.listItems,
      required this.name,
      required this.price,
      this.userId,
      this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          toolbarHeight: 15,
          collapsedHeight: 15,
          expandedHeight: 15,
          backgroundColor: FigmaColorsAuth.darkFiolet.withOpacity(0.9),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: const EdgeInsets.all(8),
            title: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          context.pushNamed('image', queryParameters: {
                            'image': imagePath,
                            'id': id,
                          });
                        },
                        icon: const Icon(
                          Icons.fullscreen,
                          color: FigmaColorsAuth.white,
                          size: 30,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            print('$name ******************');
                            final newBill = DocumentModel(
                              type: type,
                              category: category,
                              companyName: companyName,
                              dateCreated: Timestamp.fromDate(dateCreated),
                              guaranteeDate: guaranteeDate == null
                                  ? null
                                  : Timestamp.fromDate(guaranteeDate!),
                              imagePath: imagePath,
                              listItems: listItems,
                              name: name,
                              price: price,
                              userId: userId,
                              billId: id,
                            );
                            if (id != null && id!.isNotEmpty) {
                              await context
                                  .read<BillCubit>()
                                  .updadateBill(bill: newBill);
                              if (context.mounted) {
                                await context
                                    .read<DocumetsScreenCubit>()
                                    .refreshDocument();
                              }
                            } else {
                              await context.read<BillCubit>().saveBill(newBill);
                              if (context.mounted) {
                                await context
                                    .read<DocumetsScreenCubit>()
                                    .refreshDocument();
                              }
                            }

                            if (context.mounted) {
                              context.go('/main');
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          color: FigmaColorsAuth.white,
                          size: 30,
                        )),
                  ],
                ),
                state.isLoading
                    ? const Flexible(child: LinearProgressIndicator())
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
