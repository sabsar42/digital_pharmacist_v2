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

  late String ans;

  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());

    TextEditingController textField = TextEditingController();
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
                    controller.sendPrompt("Given Text : $f\n\n"
                        """
                       Here's a prompt to instruct Bard to organize and summarize the additional medical terms and sections in a medical health record:

"Please organize the following medical information into a comprehensive health record:

1. Vital Signs (including Blood Pressure, Heart Rate, Respiratory Rate, Body Temperature, and Oxygen Saturation).
2. Medical History (including Allergies, Past Medical Conditions, Surgical History, Family Medical History, and Social History).
3. Medications (including Current Medications, Dosages, and Frequency).
4. Laboratory Results (such as Blood Tests, Urinalysis, and Imaging).
5. Immunizations (Vaccination Record).
6. Physical Examination (covering General Appearance, Skin, HEENT, Cardiovascular, Respiratory, Gastrointestinal, Musculoskeletal, and Neurological).
7. Assessment and Plan (including Diagnosis, Treatment Plan, Follow-up Recommendations, and Referrals to Specialists).
8. Procedures (such as Surgical Procedures and Invasive Treatments).
9. Progress Notes (daily observations and changes in health status).
10. Patient Demographics (Date of Birth, Gender, and Contact Information).
11. Patient Complaints (Presenting Complaints).
12. Risk Factors (Risk Factors for Disease).

Please provide a well-organized summary of each section. Thank you.
                        
                        
                        """);
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
                              String apiResponse = controller.apiResponse;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultInPDFPage(
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
                            "Summary Ready ", // Add your desired text
                            style: TextStyle(fontSize: 16, color: Colors.blue), // Customize the text style
                          ),
                        ],
                      )

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
