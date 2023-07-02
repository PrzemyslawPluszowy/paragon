import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcp_new/Features/documents/cubit/documets_screen_cubit.dart';

import '../widgets/list_page_widget.dart';

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
    return SafeArea(child:
        BlocBuilder<DocumetsScreenCubit, DocumetsScreenState>(
            builder: (context, state) {
      final List<Widget> children = [
        ListPage(
            scrollController: _scrollController, documents: state.allDocuments),
        ListPage(scrollController: _scrollController, documents: state.bills),
        ListPage(
            scrollController: _scrollController, documents: state.documents),
      ];
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: SegmentedButton<PageSelect>(
                segments: const [
                  ButtonSegment(
                      value: PageSelect.all,
                      label: Text('Wszystkio'),
                      icon: Icon(Icons.all_inbox)),
                  ButtonSegment(
                      value: PageSelect.bill,
                      label: Text('Paragony'),
                      icon: Icon(Icons.receipt)),
                  ButtonSegment(
                      value: PageSelect.document,
                      label: Text('Dokumenty'),
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
              height: 20,
            ),
            Flexible(flex: 10, child: children[state.pageSelectc.index])
          ]);
    }));
  }
}
