import 'dart:convert';

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import "package:text2pdf/text2pdf.dart";
import 'package:digi_pharma_app_test/Google Berd/BardAiController.dart';
import 'dart:convert';

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';


class ResultInPDFPage extends StatefulWidget {

  final String textPdf ;

  const ResultInPDFPage({super.key, required this.textPdf});

  @override
  State<ResultInPDFPage> createState() => _ResultInPDFPageState();
}

class _ResultInPDFPageState extends State<ResultInPDFPage> {
  final _formKey = GlobalKey<FormState>();
  BardAIController bardController = Get.find<BardAIController>();

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
                  color: Colors.blue, // Border color
                  width: 2, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  content = widget.textPdf;
                  print(content);
                  setState(() {});
                  createPdf();
                },
                child: Text("Generate Pdf", style: TextStyle(fontSize: 18),), // Customize the text and size
              ),
            ),
          )

        ),
      ),
    );
  }

  createPdf() async {
    _formKey.currentState!.save();
    if (content.isNotEmpty) {
      await Text2Pdf.generatePdf(content);
    }
  }
}
