import 'package:digi_pharma_app_test/style.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MedicineInformation extends StatefulWidget {
  const MedicineInformation({Key? key}) : super(key: key);

  @override
  State<MedicineInformation> createState() => _MedicineInformationState();
}

class _MedicineInformationState extends State<MedicineInformation> {
  List<String> medName = [
    'Vitamin D',
    'Amoxicillin',
    'Levothyroxine',
    'Lisinopril',
    'Ibuprofen',
    'Amphetamine',
    'dextroamphetamine',
    'Amlodipine',
    'Albuterol HFA',
    'Prednisone',
    'Gabapentin',
    'Benzonatate',
    'Alprazolam',
    'Cyclobenzaprine',
    'Azithromycin',
    'Atorvastatin',
    'Cetirizine',
    'Losartan',
    'Amoxicillin',
    'clavulanate potassium',
    'Cephalexin',
    'Metformin',
    'Folic acid',
    'Hydrochlorothiazide',
    'Sildenafil citrate',
    'Trazodone',
    'Zolpidem tartrate',
    'Escitalopram oxalate',
    'Clonazepam',
    'Methylprednisolone',
    'Tadalafil',
    'Methocarbamol',
    'Fluconazole',
    'Sertraline',
    'Doxycycline hyclate',
    'Furosemide',
    'Fluoxetine',
    'Metronidazole',
    'Freestyle Libre',
    'Omeprazole',
    'FeroSul',
    'Sulfamethoxazole',
    'trimethoprim',
    'Phenobarbital',
    'Armour Thyroid',
    'Bromphen',
    'pseudoephedrine',
    'dextromethorphan',
    'Meloxicam',
    'Pantoprazole sodium',
    'Lisinopril',
    'Estradiol',
    'Famotidine'
  ];

  List<Map<String, dynamic>> medicineInfoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<bool> showMoreInfoList = List.generate(60, (index) => false);
  Future<void> fetchData() async {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Collection Info'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Data is on its way! Thanks for your patience.'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return buildMedicineInfo();
          }
        },
      ),
    );
  }

  Widget buildMedicineInfo() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: medicineInfoList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> medicineInfo = medicineInfoList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showMoreInfoList[index] = !showMoreInfoList[index];
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: showMoreInfoList[index]
                              ? Colors.white
                              : Colors.black,
                          border: showMoreInfoList[index]
                              ? Border.all(color: Colors.black, width: 3)
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: showMoreInfoList[index]
                                      ? [
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Medicine Name: ',
                                                    style: siz20System()),
                                                TextSpan(
                                                    text: '${medName[index]}',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Generic Name: ',
                                                    style: siz20System()),
                                                TextSpan(
                                                    text:
                                                        '${medicineInfo['generic_name']}',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Dosage Form: ',
                                                    style: siz20System()),
                                                TextSpan(
                                                    text:
                                                        '${medicineInfo['dosage_form']}',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Product Type: ',
                                                    style: siz20System()),
                                                TextSpan(
                                                    text:
                                                        '${medicineInfo['product_type']}',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Brand: ',
                                                    style: siz20System()),
                                                TextSpan(
                                                    text:
                                                        '${medicineInfo['brand_name']}',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                        ]
                                      : [
                                          //Text('Medicine Name: ${medName[index]}',style: size20White(),),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Medicine Name: ',
                                                    style: size20White()),
                                                TextSpan(
                                                    text: '${medName[index]}',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              children: [
                                                TextSpan(
                                                    text: 'Generic Name: ',
                                                    style: size20White()),
                                                TextSpan(
                                                    text:
                                                        '${medicineInfo['generic_name']}',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: showMoreInfoList[index]
                                    ? Icon(Icons.remove)
                                    : Text(
                                        '+',
                                        style: siz30White(),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
