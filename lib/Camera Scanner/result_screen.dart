import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Gemini Digi-BOT/sections/stream.dart';
import '../Google Berd/BardAiController.dart';
import '../Google Berd/BardHomePage.dart';
import 'ResultBardHomePage.dart';
import 'gemini_text_to_medRecord.dart';
import 'result_in_pdf_page.dart';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String recAndPromptText;

  @override
  void initState() {
    super.initState();
    String promptText =
        "Add a Page Title name is : (AI Prescription) and Organize this in stream Text and Give: 1.Doctor Info, 2.Medicines in Table Format, 3.Diagnosis, 4.Summary of the Diagnosis";
    recAndPromptText = promptText + widget.text;
  }

  @override
  Widget build(BuildContext context) {
    final BardAIController controller = Get.put(BardAIController());
    final TextEditingController textField = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recognized Text'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: [
                Text(
                  widget.text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TextRecogSectionTextStreamInput(
                      initialText: recAndPromptText,
                    )),
          );
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
