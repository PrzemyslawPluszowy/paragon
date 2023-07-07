import 'package:flutter/material.dart';
import 'package:rcp_new/Features/show_bill/widgets/button_menu_widget.dart';

import 'package:rcp_new/core/data/bill_model.dart';
import 'package:rcp_new/core/utils/extension.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/purple_descryption_field.dart';
import '../widgets/sliver_app_bar.dart';

class ShowBillScreen extends StatelessWidget {
  const ShowBillScreen({super.key, required this.documentModel});

  final DocumentModel documentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            transform: GradientRotation(180),
            colors: [
              Color(0xffdaedfd),
              Color(0xffdf9fea),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: CustomScrollView(
            slivers: [
              billAppBar(context, documentModel),
              SliverToBoxAdapter(
                child: ButtonMenuWidget(
                  documentModel: documentModel,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  PurpleDescryptionField(
                      title: 'Nazwa paragonu: ', value: documentModel.name!),
                  const SizedBox(
                    height: 10,
                  ),
                  PurpleDescryptionField(
                      title: 'Data paragonu: ',
                      value: documentModel.dateCreated!
                          .dateToStringFromTimestep()),
                  const SizedBox(
                    height: 10,
                  ),
                  documentModel.guaranteeDate != null
                      ? PurpleDescryptionField(
                          title: 'Koniec gwarancji: ',
                          value: documentModel.guaranteeDate!
                              .dateToStringFromTimestep())
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  documentModel.guaranteeDate != null
                      ? PurpleDescryptionField(
                          title: 'Pozostało gwarancji: ',
                          value:
                              '${documentModel.guaranteeDate!.toMonthhNumber().toInt()} misięcy')
                      : const PurpleDescryptionField(
                          title: 'Brak gwarancji', value: ''),
                  const SizedBox(
                    height: 10,
                  ),
                  PurpleDescryptionField(
                      title: 'Nazwa firmy: ',
                      value: documentModel.companyName ?? 'Brak nazwy firmy'),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  documentModel.listItems!.isEmpty
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                FigmaColorsAuth.darkFiolet,
                                FigmaColorsAuth.darkFiolet.withOpacity(0.4),
                                FigmaColorsAuth.darkFiolet.withOpacity(0)
                              ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)),
                          child: MediaQuery.removePadding(
                            context: context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(
                                    'Lista produktów',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: const Divider()),
                                ListView(
                                  padding: const EdgeInsets.all(0),
                                  addSemanticIndexes: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: documentModel.listItems!
                                      .map((e) => RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: ' * ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                            TextSpan(
                                                text: '  $e',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))
                                          ])))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        )
                ]),
              ),
            ],
          )),
    );
  }
}
