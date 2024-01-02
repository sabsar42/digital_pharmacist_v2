import 'package:digi_pharma_app_test/Camera%20Scanner/result_in_pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Google Berd/BardAiController.dart';
import 'package:digi_pharma_app_test/Google Berd/BardAiController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:digi_pharma_app_test/Camera Scanner/result_in_pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:http/http.dart' as http;


class ResultBardHomePage extends StatefulWidget {
  final String txt;

  const ResultBardHomePage({Key? key, required this.txt}) : super(key: key);

  @override
  State<ResultBardHomePage> createState() => _ResultBardHomePageState();
}

class _ResultBardHomePageState extends State<ResultBardHomePage> {

  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());

    return Scaffold(
      backgroundColor: Color(0xfff2f1f9),
      body: Padding(
        padding: EdgeInsets.all(70),
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: IconButton(
                  onPressed: () {
                    print('This\n -> ${widget.txt}');
                    controller.sendPrompt('${widget.txt},Organize the Given Text and provide following medical info to : Diagnosis,Medicine Scheduler');

                  },
                  icon: Icon(Icons.generating_tokens_outlined),
                  iconSize: 90,
                ),
              ),
            ),
            Positioned(
              top: 410,
              child: Center(
                child: Text(
                  "Tap to Generate Summary..",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                          () => controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              String apiResponse =
                                  controller.apiResponse;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResultInPDFPage(
                                        textPdf: apiResponse,
                                      ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "Summary Ready ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}