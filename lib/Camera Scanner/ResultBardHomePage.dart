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

class ResultBardHomePage extends StatefulWidget {
  final String txt;

  const ResultBardHomePage({Key? key, required this.txt}) : super(key: key);

  @override
  State<ResultBardHomePage> createState() => _ResultBardHomePageState();
}

class _ResultBardHomePageState extends State<ResultBardHomePage> {
  late String f;

  @override
  void initState() {
    super.initState();
    f = widget.txt;
  }
  late String ans ;

  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());

    TextEditingController textField = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.sendPrompt("Given Text : $f\n\n"
                "The Given Details of a Prescription in 5 sectons:"
                "1:Doctor Name 2.Patient Name  3.Diagnosis , 4.Medicince 5.Breif History of Disease");
          },
          icon: Icon(Icons.ice_skating),
        ),
      ),
      backgroundColor: Color(0xfff2f1f9),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                Obx(() => Column(
                      children: controller.historyList
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(e.system == "user" ? "👨‍💻" : "🤖"),

                                  SizedBox(width: 10),
                                  Flexible(child: Text(e.message)),
                                 // ans = e.message,
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ))
              ],
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              child: Row(children: [
                Obx(
                      () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                    onPressed: () {
                      // Correct the variable name when accessing the API response.
                      String apiResponse = controller.apiResponse;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultInPDFPage(textPdf: apiResponse), // Use apiResponse here.
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10)
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
