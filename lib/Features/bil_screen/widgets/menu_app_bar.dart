import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/bill_model.dart';
import '../../../core/theme/theme.dart';
import '../../documents/cubit/documets_screen_cubit.dart';
import '../cubit/bill_cubit.dart';

class MenuAppBarWidget extends StatelessWidget {
  const MenuAppBarWidget({
    super.key,
    required String? imagePath,
    required GlobalKey<FormState> formKey,
    required String? type,
    required String category,
    required String companyName,
    required DateTime dateCreated,
    required DateTime? guaranteeDate,
    required List<String> listItems,
    required String name,
    required double price,
    required String? userId,
    required String? id,
  })  : _imagePath = imagePath,
        _formKey = formKey,
        _type = type,
        _category = category,
        _companyName = companyName,
        _dateCreated = dateCreated,
        _guaranteeDate = guaranteeDate,
        _listItems = listItems,
        _name = name,
        _price = price,
        _userId = userId,
        _id = id;

  final String? _imagePath;
  final GlobalKey<FormState> _formKey;
  final String? _type;
  final String _category;
  final String _companyName;
  final DateTime _dateCreated;
  final DateTime? _guaranteeDate;
  final List<String> _listItems;
  final String _name;
  final double _price;
  final String? _userId;
  final String? _id;

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
                            'image': _imagePath,
                            'id': _id,
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
                          if (_formKey.currentState!.validate()) {
                            final newBill = DocumentModel(
                              type: _type,
                              category: _category,
                              companyName: _companyName,
                              dateCreated: Timestamp.fromDate(_dateCreated),
                              guaranteeDate: _guaranteeDate == null
                                  ? null
                                  : Timestamp.fromDate(_guaranteeDate!),
                              imagePath: _imagePath,
                              listItems: _listItems,
                              name: _name,
                              price: _price,
                              userId: _userId,
                              billId: _id,
                            );
                            if (_id != null && _id!.isNotEmpty) {
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
