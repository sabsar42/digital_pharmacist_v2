import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicineInformation extends StatefulWidget {
  const MedicineInformation({Key? key}) : super(key: key);

  @override
  State<MedicineInformation> createState() => _MedicineInformationState();
}

class _MedicineInformationState extends State<MedicineInformation> {
  List<String> medName = ['Motrin IV', 'Lisinopril', 'advil'];

  List<Map<String, dynamic>> medicineInfoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final String apiUrl =
        'https://drug-info-and-price-history.p.rapidapi.com/1/druginfo';

    try {
      for (String medicineName in medName) {
        final response = await http.get(
          Uri.parse(apiUrl).replace(queryParameters: {'drug': medicineName}),
          headers: {
            'X-RapidAPI-Key':
                'cc80e93d38mshd53dc305949cf21p1d5ad1jsn9859edaf78c7',
            'X-RapidAPI-Host': 'drug-info-and-price-history.p.rapidapi.com',
          },
        );

        if (response.statusCode == 200) {
          dynamic responseData = json.decode(response.body);

          for (var medicineInfo in responseData) {

              medicineInfoList.add(medicineInfo);

          }
        } else {
          print('Error: ${response.statusCode}, ${response.body}');
        }
      }
    } catch (error) {
      print('Exception: $error');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: medicineInfoList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> medicineInfo = medicineInfoList[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Colors.black,width: 2),
                      color: Color(0x76258c25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Medicine Name: ${medicineInfo['generic_name']}'),
                          Text('Dosage Form: ${medicineInfo['dosage_form']}'),
                          Text('Product Type: ${medicineInfo['product_type']}'),
                          Text('Brand: ${medicineInfo['brand_name']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
