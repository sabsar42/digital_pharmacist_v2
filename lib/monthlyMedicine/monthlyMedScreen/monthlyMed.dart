import '../../style.dart';
import 'package:flutter/material.dart';
import 'monthlyMedDetails.dart';

class monthlyMed extends StatefulWidget {
  const monthlyMed({super.key});


  @override
  State<monthlyMed> createState() => _monthlyMedState();
}

class _monthlyMedState extends State<monthlyMed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 35,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => monthlyMedDetails()));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 176,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff08346D),
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "2023",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "2 April - 2 May",
                            style: siz30White(),
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, bottom: 5),
                            child: Text(
                              "Total Medicine : 10 ",
                              style: size20White(),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
