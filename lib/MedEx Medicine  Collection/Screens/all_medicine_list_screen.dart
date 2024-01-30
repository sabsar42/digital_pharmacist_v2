import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:get/get.dart';

import '../../style.dart';
import '../Model/medicine_model.dart';
import '../widgets/medicine_card.dart';

class AllMedicineList extends StatefulWidget {
  @override
  State<AllMedicineList> createState() => _AllMedicineListState();
}

class _AllMedicineListState extends State<AllMedicineList> {
  List<MedicineModel> medicines = [];

  List<MedicineModel> _searchMedicine = [];

  @override
  void initState() {
    super.initState();
    _searchMedicine = medicines;
    loadMedicineData();
  }

  void runFilter(String enteredKeyWord) {
    List<MedicineModel> results = [];
    if (enteredKeyWord.isEmpty) {
      results = medicines;
    } else {
      results = medicines
          .where((medicine) => medicine.brandName
              .toLowerCase()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchMedicine = results;
    });
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  "Medicine Collections",
                  style: siz22White(),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.deepPurple,
                onChanged: (value) => runFilter(value),
                decoration: InputDecoration(
                  labelText: 'Search medicine',
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchMedicine.length,
                  itemBuilder: (context, index) {
                    return MedicineCard(medicine: _searchMedicine[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
