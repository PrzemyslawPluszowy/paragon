import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/documents/cubit/documets_screen_cubit.dart';
import 'package:rcp_new/core/theme/theme.dart';

import '../widgets/list_page_widget.dart';
import '../widgets/sort_drawer_widget.dart';

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
    return Scaffold(
      endDrawer: const SortDrawerWidget(),
      body: Container(
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
                scrollController: _scrollController, documents: state.bills),
            ListPage(
                scrollController: _scrollController,
                documents: state.withGwarancy),
            ListPage(
                scrollController: _scrollController,
                documents: state.withOutGwarancy),
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
                            border: Border.all(
                                color: const Color.fromARGB(66, 215, 159, 218)),
                            borderRadius: BorderRadius.circular(20),
                            color: FigmaColorsAuth.darkFiolet.withOpacity(0.5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Icon(Icons.sort,
                                    color: FigmaColorsAuth.white),
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
      ),
    );
  }
}
