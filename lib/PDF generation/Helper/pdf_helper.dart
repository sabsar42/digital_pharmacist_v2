import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;


import '../Model/prescription_model.dart'; // Update the import to your prescription model file

Future<Uint8List> pdfBuilder(PrescriptionModel prescription) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/tec-1.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Patient: ${prescription.patientName}"),
                    Text(prescription.patientAddress),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(
                    imageLogo,
                  ),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'PRESCRIPTION DETAILS',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ...prescription.medications.map(
                      (medication) => TableRow(
                    children: [
                      Expanded(
                        flex: 2,
                        child: textAndPadding(medication.medicationName),
                      ),
                      Expanded(
                        flex: 1,
                        child: textAndPadding(medication.dosage),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "THANK YOU FOR CHOOSING OUR SERVICES!",
                style: Theme.of(context).header2,
              ),
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget textAndPadding(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: const EdgeInsets.all(1),
      child: Text(
        text,
        textAlign: align,
      ),
    );
