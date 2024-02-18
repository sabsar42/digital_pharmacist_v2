import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:digi_pharma_app_test/medical_history/EHR%20Record/widget/ehr_image_upload.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widget/PopBup_Menu_Three_Button_Functions_Screen.dart';
import '../widget/ehr_card_view.dart';
import 'EHR_Detailed_View.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EHR_First_Screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

class EHRArticleDetailScreen extends StatefulWidget {
  final String folderName;
  final String uniqueDiagnosisNumber;

  EHRArticleDetailScreen({
    required this.folderName,
    required this.uniqueDiagnosisNumber,
  });

  @override
  State<EHRArticleDetailScreen> createState() =>
      _EHRArticleDetailScreenState();
}

class _EHRArticleDetailScreenState extends State<EHRArticleDetailScreen> {
  late User currentUser;
  String? userID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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

  Future<void> deleteEHRImage(String documentID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection("healthRecords")
        .doc(widget.uniqueDiagnosisNumber)
        .collection("ehr_folders")
        .doc(widget.folderName)
        .collection('${widget.folderName}_images')
        .doc(documentID)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EHRScreen(
                    uniqueDiagnosisNumber: widget.uniqueDiagnosisNumber)));
        return false;
      },
      child: Scaffold(
        appBar: ehrAppbar(context),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .collection("healthRecords")
              .doc(widget.uniqueDiagnosisNumber)
              .collection("ehr_folders")
              .doc(widget.folderName)
              .collection('${widget.folderName}_images')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No EHR File Uploaded'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String documentID = snapshot.data!.docs[index].id;
                  String url = snapshot.data!.docs[index]['downloadURL'];
                  String description = 'description';

                  return EhrCardView(
                    url: url,
                    description: description,
                    onDelete: () => deleteEHRImage(documentID),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ImageUpload(
                  userID: userID,
                  folderName: widget.folderName,
                  uniqueDiagnosisNumber: widget.uniqueDiagnosisNumber,
                ),
              ),
            );
          },
          backgroundColor: Colors.teal.shade300,
          child: Container(
            width: 100,
            child: Icon(Icons.upload_rounded, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }

  AppBar ehrAppbar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.teal.shade300,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(5, 70, 65, 1.0),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text('EHR Detail',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(5, 70, 65, 1.0),
          )),
      backgroundColor: Color.fromRGBO(246, 238, 250, 1.0),
    );
  }
}
