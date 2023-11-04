import 'dart:convert';
import 'dart:ffi';

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
  const ResultInPDFPage({super.key});

  @override
  State<ResultInPDFPage> createState() => _ResultInPDFPageState();
}

class _ResultInPDFPageState extends State<ResultInPDFPage> {
  final _formKey = GlobalKey<FormState>();
  BardAIController bardController = Get.find<BardAIController>();

  String content = '';

  @override
  void initState() {
    super.initState();
    content = bardController.bardReplay.value;
  }

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
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                  ),
                ),
                child: TextFormField(
                  onSaved: (val) {
                    content = val!;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  createPdf();
                },
                child: const Text("Generate Pdf"),
              )
            ],
          ),
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
