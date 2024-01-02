import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ResultInPDFPage extends StatefulWidget {
  final String textPdf;

  const ResultInPDFPage({Key? key, required this.textPdf}) : super(key: key);

  @override
  State<ResultInPDFPage> createState() => _ResultInPDFPageState();
}

class _ResultInPDFPageState extends State<ResultInPDFPage> {
  final _formKey = GlobalKey<FormState>();
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Prescription Summary"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () async {
                  await createPdfAndNavigate();
                },
                child: Text(
                  "Generate Pdf",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createPdfAndNavigate() async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      // Handle denied or restricted permission
      print('Storage permission denied.');
      return;
    }

    // Save PDF and navigate
    await createPdf();
  }

  Future<void> createPdf() async {
    _formKey.currentState!.save();

    if (content.isNotEmpty) {
      final Uint8List pdfBytes = await generatePdf(content);
      final String pdfPath = await savePdfToFile(pdfBytes);
      await copyPdfToAssets(pdfPath);
      navigateToHealthRecordDetailScreen();
    }
  }

  Future<Uint8List> generatePdf(String content) async {
    final pw.Document pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(content),
        );
      },
    ));

    return pdf.save();
  }

  Future<String> savePdfToFile(Uint8List pdfBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final pdfPath = '${directory.path}/generated_pdf.pdf';
    print('PDF Path: $pdfPath'); // Debugging statement
    final pdfFile = File(pdfPath);

    await pdfFile.writeAsBytes(pdfBytes);

    return pdfPath;
  }

  Future<void> copyPdfToAssets(String pdfPath) async {
    // Replace 'assets/generated_pdf.pdf' with the desired asset path
    final assetPath = 'assets/pdf.pdf';
    final assetFile = File(assetPath);

    await assetFile.writeAsBytes(await File(pdfPath).readAsBytes());
  }

  void navigateToHealthRecordDetailScreen() {
    // Replace 'HealthRecordDetailScreen' with your actual screen name
    print('Navigating to HealthRecordDetailScreen');
  }
}
