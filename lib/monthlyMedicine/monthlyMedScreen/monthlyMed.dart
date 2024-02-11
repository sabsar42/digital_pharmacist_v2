import 'package:digi_pharma_app_test/common_background.dart';

import '../../style.dart';
import 'package:flutter/material.dart';
import 'monthlyDatabase.dart';
import 'monthlyMedDetails.dart';

class monthlyMed extends StatefulWidget {
  const monthlyMed({super.key});

  @override
  State<monthlyMed> createState() => _monthlyMedState();
}

class _monthlyMedState extends State<monthlyMed> {
  TextEditingController dateController = TextEditingController();
  TextEditingController prevDateController = TextEditingController();

  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<int> lastDates = [
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  void updateDate(int selectedIndex) {
    print(selectedIndex);
    if (selectedIndex == 0) {
      int lastDate = lastDates[selectedIndex];
      DateTime selectedDate =
      DateTime(DateTime.now().year, selectedIndex + 1, lastDate);
      dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      print(dateController.text);
    } else {
      int lastDate = lastDates[selectedIndex];
      int prevMonthLastDate = lastDates[selectedIndex - 1];
      DateTime selectedDate =
      DateTime(DateTime.now().year, selectedIndex + 1, lastDate);
      DateTime prevMonthDate =
      DateTime(DateTime.now().year, selectedIndex, prevMonthLastDate);
      dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      prevDateController.text =
      prevMonthDate.toLocal().toString().split(' ')[0];
      print(dateController.text);
      print(prevDateController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MONTHLY MEDICINE',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,

          ),),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 35,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(

        child: CommonBackground(
          child: ListView.builder(
              itemCount: monthList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    updateDate(index);
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonthlyMedDetails(
                                index: index,
                                time1: dateController,
                                time2: prevDateController,
                              )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonthlyMedDetails(
                                index: index,
                                time1: dateController,
                                time2: prevDateController,
                              )));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 176,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/dashboard_card.png",  // Replace with the URL of your image
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "2024",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${monthList[index]}",
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
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}