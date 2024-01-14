import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Google%20Berd/BardAiController.dart';
import 'package:digi_pharma_app_test/medical_history/PDF%20Prescription/screens/image_to_pdf_conversion_screen.dart';
import 'package:digi_pharma_app_test/medical_history/PDF%20Prescription/screens/pdf_viewer_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPdfScreen extends StatefulWidget {
  final String uniqueDiagnosisNumber;

  const FirstPdfScreen({super.key, required this.uniqueDiagnosisNumber});

  @override
  State<FirstPdfScreen> createState() => _FirstPdfScreenState();
}

class _FirstPdfScreenState extends State<FirstPdfScreen> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late User currentUser;
  late String userID;
  List<Map<String, dynamic>> pdfData = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getALlPdf();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
        userID = currentUser.uid;
      });
    }
  }

  void showSnackBar(String message, Duration duration) {
    var snackbar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<String?> uploadPDF(String fileName, File file) async {
    final reference = FirebaseStorage.instance
        .ref()
        .child('${userID}')
        .child("pdf_folder/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {
      showSnackBar('SUCCESS', Duration(seconds: 3));
    });

    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      final downloadLink = await uploadPDF(fileName, file);

      await firebaseFirestore
          .collection("users")
          .doc(userID)
          .collection("healthRecords")
          .doc(widget.uniqueDiagnosisNumber)
          .collection("pdf_folders")
          .add({
        "name": fileName,
        "url": downloadLink,
      }).whenComplete(() => showSnackBar(
              'Image uploaded successfully!', Duration(seconds: 2)));
    }
  }

  bool isAddingPDF = true;

  Future getALlPdf() async {
    final result = await firebaseFirestore
        .collection('users')
        .doc(userID)
        .collection("healthRecords")
        .doc(widget.uniqueDiagnosisNumber)
        .collection("pdf_folders")
        .get();

    pdfData = result.docs.map((e) => e.data()).toList();
    setState(() {
      isAddingPDF = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await getALlPdf();
        },
        child: isAddingPDF
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: pdfData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PDFViewerScreen(
                                      pdfUrl: pdfData[index]['url'],
                                      pdfName: pdfData[index]['name'],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/pdf_logo.png",
                              height: 120,
                              width: 120,
                            ),
                            Text(
                              pdfData[index]['name'],
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              pickFile();
            },
            style: TextButton.styleFrom(
              elevation: 4,
              backgroundColor: Colors.purple.shade800,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Upload PDF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0), // Add spacing between buttons
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageToPDF(uniqueDiagnosisNumber: widget.uniqueDiagnosisNumber,)),
              );
            },
            style: TextButton.styleFrom(
              elevation: 4,
              backgroundColor: Colors.deepPurple.shade800,
              padding: EdgeInsets.all(13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Convert to PDF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
