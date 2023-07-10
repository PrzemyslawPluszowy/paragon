import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:rcp_new/core/data/bill_model.dart';
import 'package:rcp_new/core/utils/extension.dart';

import '../models/pdf_model.dart';

abstract class PdfController {
  pw.Document createPdf(
      List<DocumetsToPdfModel> data, List<pw.Widget> template);

  Future<List<DocumetsToPdfModel>> getDocumentsToPdf(List<DocumentModel> data);
  List<pw.Widget> pdfPageLayOut(List<DocumetsToPdfModel> data);
  Future<void> previewPDF(pw.Document doc);
}

class PdfControllerImpl implements PdfController {
  @override
  pw.Document createPdf(
      List<DocumetsToPdfModel> userData, List<pw.Widget> template) {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text('Twoje Paragony',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 26)),
                  pw.Divider(),
                ]),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisSize: pw.MainAxisSize.max,
                children: template),
          ];
        }));
    return pdf;
  }

  @override
  Future<List<DocumetsToPdfModel>> getDocumentsToPdf(
      List<DocumentModel> data) async {
    List<DocumetsToPdfModel> dataForPdf = [];

    try {
      for (var element in data) {
        final image = await networkImage(element.imagePath!);
        dataForPdf.add(DocumetsToPdfModel(
          name: element.name ?? 'brak nazwy',
          dateCreated: element.dateCreated == null
              ? 'brak daty'
              : element.dateCreated!.dateToStringFromTimestep(),
          listItems: element.listItems ?? [],
          price: element.price,
          imageProvider: image,
          companyName: element.companyName ?? 'brak nazwy firmy',
          category: element.category ?? 'brak kategorii',
          guaranteeDate: element.guaranteeDate == null
              ? 'brak daty gwarancji'
              : element.guaranteeDate!.dateToStringFromTimestep(),
        ));
      }
    } catch (e) {
      throw Exception(e);
    }

    return dataForPdf;
  }

  @override
  List<pw.Widget> pdfPageLayOut(List<DocumetsToPdfModel> data) {
    final List<pw.Widget> bill = data
        .map(
          (e) => pw.ListView(
            children: [
              pw.Container(
                child: pw.Column(
                  children: [
                    pw.Divider(),
                    pw.Text(e.name, style: const pw.TextStyle(fontSize: 20)),
                    pw.Text('Data paragonu ${e.dateCreated}',
                        style: const pw.TextStyle(fontSize: 20)),
                    pw.Text('Kategoria ${e.category}',
                        style: const pw.TextStyle(fontSize: 20)),
                    pw.Text('Gwarancja do: ${e.guaranteeDate}',
                        style: const pw.TextStyle(fontSize: 20)),
                    pw.Text('${e.price} pln',
                        style: const pw.TextStyle(fontSize: 20)),
                    pw.Image(e.imageProvider,
                        height: 400, fit: pw.BoxFit.fitHeight),
                    pw.Divider(),
                  ],
                ),
              ),
            ],
          ),
        )
        .toList();
    return bill;
  }

  @override
  Future<void> previewPDF(pw.Document doc) async {
    try {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    } catch (e) {
      throw Exception(e);
    }
  }
}
