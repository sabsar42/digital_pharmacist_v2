import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../MedEx Medicine  Collection/Model/medicine_model.dart';
import '../../MedEx Medicine  Collection/widgets/medicine_card.dart';
import '../../common_background.dart';
import '../../style.dart';

class MonthlyMedDetails extends StatefulWidget {
  const MonthlyMedDetails({
    Key? key,
    required this.index,
    required this.time1,
    this.time2,
  });

  final int index;
  final TextEditingController time1;
  final TextEditingController? time2;

  @override
  State<MonthlyMedDetails> createState() => _MonthlyMedDetailsState();
}

class _MonthlyMedDetailsState extends State<MonthlyMedDetails> {
  List<MedicineModel> medicines = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    loadMedicineData();
  }

  late User currentUser;
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
  List<String> medImages = [
    'assets/images/dashboard_1.png',
    'assets/images/dashboard_2.png',
    'assets/images/dashboard_3.png',
    'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png',
    'assets/images/dashboard_2.png',
    'assets/images/dashboard_3.png',
    'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png',
    'assets/images/dashboard_2.png',
    'assets/images/dashboard_3.png',
    'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png',
    'assets/images/dashboard_2.png',
    'assets/images/dashboard_3.png',
    'assets/images/dashboard_4.png',
  ];

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<List<Map<String, dynamic>>> getData() async {
    DateTime endMonth = DateFormat("yyyy-MM-dd").parse(widget.time1.text);
    DateTime prevEndMonth = DateFormat("yyyy-MM-dd").parse(widget.time2!.text);
    String userID = currentUser.uid;

    try {
      if (widget.index == 0) {
        var resultTimestamp = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('remindersSet')
            .where('timestamp', isLessThanOrEqualTo: endMonth)
            .get();

        List<Map<String, dynamic>> records = [];

        resultTimestamp.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          records.add(data);
        });

        return records;
      } else {
        var resultTimestamp = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('remindersSet')
            .where('timestamp', isGreaterThanOrEqualTo: prevEndMonth)
            .where('timestamp', isLessThanOrEqualTo: endMonth)
            .get();

        var resultValidTill = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('remindersSet')
            .where('validtill', isGreaterThanOrEqualTo: prevEndMonth)
            .where('validtill', isLessThanOrEqualTo: endMonth)
            .get();

        List<Map<String, dynamic>> records = [];

        resultTimestamp.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          records.add(data);
        });

        resultValidTill.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          records.add(data);
        });

        return records;
      }
    } catch (error) {
      print("Error fetching records: $error");
      return [];
    }
  }

  Future<void> loadMedicineData() async {
    final ByteData data =
    await rootBundle.load('assets/medicineCSV/medicine.csv');
    final String rawMedicineData =
    String.fromCharCodes(data.buffer.asUint8List());

    List<List<dynamic>> parsedCsv =
    const CsvToListConverter().convert(rawMedicineData);

    List<MedicineModel> loadedMedicines = [];

    for (List<dynamic> row in parsedCsv) {
      if (row.length == 10) {
        loadedMedicines.add(
          MedicineModel(
            brandId: row[0].toString(),
            brandName: row[1].toString(),
            type: row[2].toString(),
            slug: row[3].toString(),
            dosageForm: row[4].toString(),
            generic: row[5].toString(),
            strength: row[6].toString(),
            manufacturer: row[7].toString(),
            packageContainer: row[8].toString(),
            packageSize: row[9].toString(),
          ),
        );
      }
    }
    setState(() {
      medicines.addAll(loadedMedicines);
    });
  }

  MedicineModel? findMedicineByName(String name) {
    return medicines.firstWhereOrNull((medicine) => medicine.brandName == name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
            toolbarHeight: 100,
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
                "${monthList[widget.index]} - 2024",
                style: siz22White(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> data = snapshot.data ?? [];
            return CommonBackground(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(show: true),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: const Color(0xff37434d),
                            width: 1,
                          ),
                        ),
                        minX: 0,
                        maxX: data.length.toDouble(),
                        minY: 0,
                        maxY: 100, // Adjust this based on your data range
                        lineBarsData: [
                          LineChartBarData(
                            spots: data.map((entry) {
                              return FlSpot(
                                data.indexOf(entry).toDouble(),
                                entry['value']?.toDouble() ?? 0.0, // Replace 'value' with the actual key
                              );
                            }).toList(),
                            isCurved: true,
                            color: Colors.red,
                            belowBarData: BarAreaData(show: true),
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        String medicineName = data[index]['medicineName'];
                        MedicineModel? matchedMedicine =
                        findMedicineByName(medicineName);

                        if (matchedMedicine != null) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    medImages[index],
                                    width: 40,
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Starting Date:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${DateFormat('yyyy-MM-dd').format(data[index]['timestamp'].toDate())}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Ending Date:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${DateFormat('yyyy-MM-dd').format(data[index]['validtill'].toDate())}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  MedicineCard(medicine: matchedMedicine),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (_, __) {
                        return Divider(
                          height: 1,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
