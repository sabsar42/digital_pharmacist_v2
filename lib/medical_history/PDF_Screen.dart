import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'Three_Button_Functions_Screen.dart';

class PDFViewerScreen extends StatefulWidget {
  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 45,
      //   elevation: 20.0,
      //   backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
      //   title: Text(
      //     'EHR Health Record',
      //     style: TextStyle(
      //       fontSize: 22,
      //       color: Colors.deepPurple,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //     actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(
      //         Icons.bookmark_outline_rounded,
      //         color:  Color.fromRGBO(111, 78, 140, 1.0),
      //         semanticLabel: 'Bookmark',
      //         size: 30,
      //       ),
      //       onPressed: () {
      //         _pdfViewerKey.currentState?.openBookmarkView();
      //       },
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(38.0), // Adjust the height as needed
      //     child: BuildThreeButton(),
      //   ),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(15),
      //       bottomRight: Radius.circular(15),
      //     ),
      //   ),
      // ),

      body: SfPdfViewer.network(
        'https://www.africau.edu/images/default/sample.pdf',
        key: _pdfViewerKey,
          canShowScrollHead: true,
          canShowScrollStatus: true,



      ),
    );
  }
}


