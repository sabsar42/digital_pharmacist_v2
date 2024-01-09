import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:digi_pharma_app_test/medical_history/PDF_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import 'BookMark_List_Screen.dart';
import 'EHR_First_Screen.dart';

class TabBarScreen extends StatefulWidget {
  final String uniqueDocID;

  TabBarScreen({required this.uniqueDocID});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  // String get uniqueDocIdNumber => widget.uniqueDocID;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool currentState = true;

  String id = '';

  @override
  void initState() {
    super.initState();
    id = widget.uniqueDocID.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Color.fromRGBO(224, 182, 250, 1.0),
            toolbarHeight: 30,
            elevation: 6.0,
            backgroundColor: Color.fromRGBO(252, 247, 255, 1.0),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(124, 67, 166, 1.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.bookmark_add_rounded,
                  color: Color.fromRGBO(111, 78, 140, 1.0),
                  semanticLabel: 'Bookmark',
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookMarkScreen()));
                },
              ),
            ],
            title: Text(
              '${id[id.length - 1]} : Health Record',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(124, 67, 166, 1.0),
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorWeight: 2.0,
              // Thickness of the tab indicator

              indicatorColor: Color.fromRGBO(124, 67, 166, 1.0),
              labelColor: Color.fromRGBO(124, 67, 166, 1.0),
              tabs: [
                Tab(
                    icon: Icon(
                      Icons.medical_information_rounded,
                      color: Color.fromRGBO(124, 67, 166, 1.0),
                      size: 18,
                    ),
                    text: "Detail Info"),
                Tab(
                    icon: Icon(
                      Icons.create_new_folder_outlined,
                      color: Color.fromRGBO(124, 67, 166, 1.0),
                      size: 18,
                    ),
                    text: "EHR Folder"),
                Tab(
                    icon: Icon(
                      Icons.picture_as_pdf_sharp,
                      color: Color.fromRGBO(124, 67, 166, 1.0),
                      size: 18,
                    ),
                    text: "PDF Prescription")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HealthRecordDetailScreen(
                diagnosisNumber: widget.uniqueDocID,
              ),
              EHRScreen(diagnosisNumberfromPrev: "1"),
              PDFViewerScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
