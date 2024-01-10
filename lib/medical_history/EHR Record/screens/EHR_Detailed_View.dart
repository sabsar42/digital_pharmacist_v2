import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:digi_pharma_app_test/medical_history/EHR%20Record/widget/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widget/PopBup_Menu_Three_Button_Functions_Screen.dart';
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

  EHRArticleDetailScreen({required this.folderName});

  @override
  State<EHRArticleDetailScreen> createState() => _EHRArticleDetailScreenState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ehrAppbar(context),
        body: Center(
          child: Column(
            children: [
              Icon(
                Icons.folder,
                size: 80.0,
                color: Color.fromRGBO(37, 83, 147, 0.7215686274509804),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.folderName,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageUpload(
                          userID: userID,
                          folderName: widget.folderName,
                        )));
          },
          backgroundColor: Colors.purple.shade300,
          child: Container(
            width: 100,
            child: Icon(Icons.upload_outlined, size: 30, color: Colors.white),
          ),
        ));
  }

  AppBar ehrAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(124, 67, 166, 1.0),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text('EHR Detail',
          style: TextStyle(
            color: Color.fromRGBO(124, 67, 166, 1.0),
          )),
      backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
    );
  }
}
