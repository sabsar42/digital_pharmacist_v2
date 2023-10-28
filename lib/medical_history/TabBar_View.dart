import 'package:digi_pharma_app_test/medical_history/EHR_First_Screen.dart';
import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:digi_pharma_app_test/medical_history/PDF_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  final String diagnosisNumberfromPrev;

  TabBarScreen({required this.diagnosisNumberfromPrev});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 25,
            elevation: 6.0,
            backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
              color: Color.fromRGBO(124, 67, 166, 1.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              '$diagnosisNumberfromPrev - Health Record',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromRGBO(124, 67, 166, 1.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorWeight: 3.0, // Thickness of the tab indicator

              indicatorColor: Color.fromRGBO(124, 67, 166, 1.0),
              labelColor: Color.fromRGBO(124, 67, 166, 1.0),
              tabs: [
                Tab(
                    icon: Icon(Icons.medical_information_rounded,
                        color: Color.fromRGBO(124, 67, 166, 1.0)),
                    text: "Detail Info"),
                Tab(
                    icon: Icon(Icons.create_new_folder_outlined,
                        color: Color.fromRGBO(124, 67, 166, 1.0)),
                    text: "EHR Folder"),
                Tab(
                    icon: Icon(Icons.picture_as_pdf_sharp,
                        color: Color.fromRGBO(124, 67, 166, 1.0)),
                    text: "PDF Prescription")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HealthRecordDetailScreen(diagnosisNumberfromPrev: '1'),
              EHRScreen(diagnosisNumberfromPrev: "1"),
              PDFViewerScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
