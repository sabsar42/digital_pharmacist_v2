import 'package:digi_pharma_app_test/Upload%20to%20Scanner/UploadScreenPreview.dart';
import 'package:digi_pharma_app_test/dasboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'BardAiController.dart';

class BardHomePage extends StatefulWidget {
  const BardHomePage({super.key});

  @override
  State<BardHomePage> createState() => _BardHomePageState();
}

class _BardHomePageState extends State<BardHomePage> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());
    TextEditingController textField = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xfff2f1f9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "BARD",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                controller.sendPrompt("Organize The Given Details of a Prescription in 3 sectons:"
                    "1: Diagnosis , 2. Medicince 3. Breif History of Disease");
              },
              icon: Icon(Icons.security))
        ],
      ),
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
                Expanded(
                  child: TextFormField(
                    controller: textField,
                    decoration: InputDecoration(
                        hintText: "You can ask what you want",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                Obx(
                      () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                      onPressed: () {
                        if (textField.text != "") {
                          controller.sendPrompt(textField.text);
                          textField.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 10)
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            print(_selectedIndex);
          });

          switch (_selectedIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );setState(() {
                _selectedIndex=index;
              });
              break;

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadScreenPreview(),
                ),
              );setState(() {
                _selectedIndex=index;
              });
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BardHomePage(),
                ),
              );setState(() {
                _selectedIndex=index;
              });
              break;
          }
        },
        currentIndex: _selectedIndex,

       selectedItemColor: Color.fromRGBO(62, 34, 148, 1.0),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'DigiBOT'),
        ],
      ),
    );
  }
}