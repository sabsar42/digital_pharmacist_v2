import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../Gemini Digi-BOT/widgets/item_image_view.dart';
import '../style.dart';

class TextRecogSectionTextStreamInput extends StatefulWidget {
  final String? initialText;

  const TextRecogSectionTextStreamInput({Key? key, required this.initialText})
      : super(key: key);

  @override
  State<TextRecogSectionTextStreamInput> createState() =>
      _SectionTextInputStreamState();
}

class _SectionTextInputStreamState
    extends State<TextRecogSectionTextStreamInput> {
  final gemini = Gemini.instance;
  String? searchedText, _finishReason;
  List<Uint8List>? images;

  String? get finishReason => _finishReason;

  set finishReason(String? set) {
    if (set != _finishReason) {
      setState(() => _finishReason = set);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      promptGemini(widget.initialText!);
    }
  }

  void promptGemini(String text) {
    searchedText = text;
    gemini.streamGenerateContent(searchedText!, images: images).listen((value) {
      setState(() {
        images = null;
      });

      if (value.finishReason != 'STOP') {
        finishReason = 'Finish reason is `RECITATION`';
      }
    }).onError((e) {
      log('streamGenerateContent error', error: e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
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
                "AI Generated Prescription ",
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
            child: GeminiResponseTypeView(
              builder: (context, child, response, loading) {
                if (loading) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/digi-pharma-prussian.svg',
                        ),
                      ),
                    ),
                  );
                }

                if (response != null) {
                  return Markdown(
                    data: response,
                    selectable: true,
                  );
                } else {
                  return const Center(child: Text('Search something!'));
                }
              },
            ),
          ),
          if (finishReason != null) Text(finishReason!),
          if (images != null)
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.centerLeft,
              child: Card(
                child: ListView.builder(
                  itemBuilder: (context, index) => ItemImageView(
                    bytes: images!.elementAt(index),
                  ),
                  itemCount: images!.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}