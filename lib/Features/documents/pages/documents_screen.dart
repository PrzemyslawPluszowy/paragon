import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/documents/cubit/documets_screen_cubit.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../widgets/list_page_widget.dart';

const List<String> dropDownList = <String>[
  'Po dacie ',
  'Po dacie gwarancji',
  'Po nazwie',
];

enum PageSelect {
  all,
  bill,
  document,
}

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool prevendMultipleRequest = false;
  String dropdownValue = dropDownList.first;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!prevendMultipleRequest) {
          prevendMultipleRequest = true;

          await context.read<DocumetsScreenCubit>().loadBills().then((_) {
            prevendMultipleRequest = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        transform: GradientRotation(0),
        colors: [
          Color(0xffdaedfd),
          Color.fromARGB(174, 231, 183, 239),
          Color(0xffdaedfd),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: SafeArea(child:
          BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
              builder: (context, state) {
        final List<Widget> children = [
          ListPage(
              scrollController: _scrollController,
              documents: state.allDocuments),
          ListPage(scrollController: _scrollController, documents: state.bills),
          ListPage(
              scrollController: _scrollController, documents: state.documents),
        ];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: SegmentedButton<PageSelect>(
                    segments: const [
                      ButtonSegment(
                          value: PageSelect.all,
                          label: Text(
                            'Wszystkio',
                            style: TextStyle(fontSize: 13),
                          ),
                          icon: Icon(Icons.all_inbox)),
                      ButtonSegment(
                          value: PageSelect.bill,
                          label: Text(
                            'Paragony gwarancyjne',
                            style: TextStyle(fontSize: 13),
                          ),
                          icon: Icon(Icons.receipt)),
                      ButtonSegment(
                          value: PageSelect.document,
                          label: Text('Bez gwarancji',
                              style: TextStyle(fontSize: 13)),
                          icon: Icon(Icons.document_scanner)),
                    ],
                    selectedIcon: const Icon(Icons.check),
                    selected: <PageSelect>{state.pageSelectc},
                    onSelectionChanged: (Set<PageSelect> value) {
                      context
                          .read<DocumetsScreenCubit>()
                          .pageSelect(pageSelectc: value.first);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(20),
                          color: FigmaColorsAuth.white.withOpacity(0.5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Sortuj: ',
                              style: Theme.of(context).textTheme.bodySmall),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              elevation: 20,
                              isDense: true,
                              style: const TextStyle(
                                  fontSize: 12, color: FigmaColorsAuth.black),
                              borderRadius: BorderRadius.circular(20),
                              value: state.dropdownMenuSelect,
                              items: dropDownList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                context
                                    .read<DocumetsScreenCubit>()
                                    .dropDownMenuSelect(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(flex: 10, child: children[state.pageSelectc.index])
              ]),
        );
      })),
    );
  }
}
