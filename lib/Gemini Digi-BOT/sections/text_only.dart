import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../style.dart';
import '../widgets/chat_input_box.dart';

class SectionTextInput extends StatefulWidget {
  const SectionTextInput({Key? key}) : super(key: key);

  @override
  State<SectionTextInput> createState() => _SectionTextInputState();
}

class _SectionTextInputState extends State<SectionTextInput> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

  @override
  void initState() {
    super.initState();
    // Set a default prompt when the screen is initialized
    result = "Welcome! I am your AI Digi-Bot!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/dashboard_card.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: AppBar(
            toolbarHeight: 45,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.purple.shade50,
                size: 25,
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Digi-Pharma BOT",
                style: siz22White(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (searchedText != null)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade700,
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                      ),
                      child: Text(
                        'User: $searchedText',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Expanded(
                    child: loading
                        ? Center(
                      child: SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: SvgPicture.asset(
                          'assets/images/digi-pharma-prussian.svg',
                        ),
                      ),
                    )
                        : result != null
                        ? Markdown(data: result!)
                        : Center(child: Text('Ask something!')),
                  ),
                ],
              ),
            ),
          ),
          ChatInputBox(
            controller: controller,
            onSend: () {
              if (controller.text.isNotEmpty) {
                searchedText = controller.text;
                controller.clear();
                loading = true;

                gemini.text(searchedText!).then((value) {
                  result = value?.content?.parts?.last.text;
                  loading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
