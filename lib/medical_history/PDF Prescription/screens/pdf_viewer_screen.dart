import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const PDFViewerScreen({
    Key? key,
    required this.pdfUrl,
    required this.pdfName,
  }) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.deepPurple.shade100,
        title: Text(
          'PDF : ${widget.pdfName}',
          style: TextStyle(color: Colors.deepPurple),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.pdfUrl != null
          ? SfPdfViewer.network(
              widget.pdfUrl,
              key: _pdfViewerKey,
              canShowScrollHead: true,
              canShowScrollStatus: true,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  // Future<bool> _onWillPop() async {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => PDFViewerScreen(pdfUrl: '', pdfName: '')));
  //   return true;
  // }
}
