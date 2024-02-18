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

  const FirstPdfScreen({Key? key, required this.uniqueDiagnosisNumber})
      : super(key: key);

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
        .child('$userID')
        .child('pdf_folder/$fileName.pdf');
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {
      showSnackBar('PDF uploaded successfully!', Duration(seconds: 2));
    });

    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  void pickFile() async {
    setState(() {
      isAddingPDF = true; // Show circular progress indicator
    });

    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files.first.name;
      File file = File(pickedFile.files.first.path!);
      final downloadLink = await uploadPDF(fileName, file);

      await firebaseFirestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc(widget.uniqueDiagnosisNumber)
          .collection('pdf_folders')
          .add({
        'name': fileName,
        'url': downloadLink,
      });

      setState(() {
        isAddingPDF = false; // Hide circular progress indicator
      });

      showSnackBar('PDF uploaded successfully!', Duration(seconds: 2));
      getALlPdf();
    } else {
      setState(() {
        isAddingPDF = false; // Hide circular progress indicator
      });
    }
  }

  Future<void> deletePDF(String pdfName) async {
    QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
        .collection('users')
        .doc(userID)
        .collection('healthRecords')
        .doc(widget.uniqueDiagnosisNumber)
        .collection('pdf_folders')
        .where('name', isEqualTo: pdfName)
        .get();

    if (result.docs.isNotEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Deletion'),
            content: Text('Are you sure you want to delete this PDF?'),
            backgroundColor: Color.fromRGBO(215, 246, 244, 1.0),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await firebaseFirestore
                      .collection('users')
                      .doc(userID)
                      .collection('healthRecords')
                      .doc(widget.uniqueDiagnosisNumber)
                      .collection('pdf_folders')
                      .doc(result.docs.first.id)
                      .delete();

                  Navigator.pop(context);
                  showSnackBar(
                      'PDF deleted successfully!', Duration(seconds: 2));
                  getALlPdf();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  bool isAddingPDF = true;

  Future<void> getALlPdf() async {
    final result = await firebaseFirestore
        .collection('users')
        .doc(userID)
        .collection('healthRecords')
        .doc(widget.uniqueDiagnosisNumber)
        .collection('pdf_folders')
        .get();

    pdfData = result.docs.map((e) => e.data()).toList();
    setState(() {
      isAddingPDF = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Documents'),
        backgroundColor: Colors.teal.shade50,
      ),
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
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: pdfData.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              color: Colors.teal.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewerScreen(
                        pdfUrl: pdfData[index]['url'],
                        pdfName: pdfData[index]['name'],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/pdf_logo.png',
                            height: 80,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            pdfData[index]['name'],
                            style: TextStyle(
                              fontSize: 14.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4.0,
                      right: 4.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deletePDF(pdfData[index]['name']);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pickFile();
        },
        label: Text(
          'Upload PDF',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.file_upload),
        backgroundColor: Colors.teal.shade800,
      ),
    );
  }
}
