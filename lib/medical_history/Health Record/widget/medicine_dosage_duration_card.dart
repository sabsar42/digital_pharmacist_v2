import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicineRow extends StatefulWidget {
  final String uniqueDiagnosisNumber;

  MedicineRow({
    required this.uniqueDiagnosisNumber,
  });

  @override
  State<MedicineRow> createState() => _MedicineRowState();
}

class _MedicineRowState extends State<MedicineRow> {
  late User currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MedicineInfo> medicinesInfo = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
    loadMedicineDetails();
  }

  Future<void> addMedicalDetails(int index) async {
    String userID = currentUser.uid;
    String uniqueID = widget.uniqueDiagnosisNumber;


    /// for ADDING DRUGS_COLLECTIONS
    CollectionReference<Map<String, dynamic>> drugsCollection =
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('drugsCollection');

    CollectionReference<Map<String, dynamic>> medicineDetailsCollection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('healthRecords')
            .doc(uniqueID)
            .collection('medicine_dosage_duration');

    MedicineInfo medicineInfo = medicinesInfo[index];

    String uniqueMedID = '$uniqueID-$index';

    Map<String, dynamic> newRecord = {
      'medicine_name': medicineInfo.nameController.text,
      'frequency': medicineInfo.frequencyController.text,
      'duration': medicineInfo.durationController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    ///DRUGS_Collection
    drugsCollection.doc(uniqueMedID).set({
      'medicine_name': medicineInfo.nameController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await medicineDetailsCollection.doc(uniqueMedID).set(newRecord);
  }

  void onMedicineInputChange(int index) {
    addMedicalDetails(index);
  }

  Future<void> loadMedicineDetails() async {
    String userID = currentUser.uid;
    String uniqueID = widget.uniqueDiagnosisNumber;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc(uniqueID)
          .collection('medicine_dosage_duration')
          .get();

      List<MedicineInfo> loadedMedicines = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        MedicineInfo medicineInfo = MedicineInfo();

        medicineInfo.nameController.text = data['medicine_name'] ?? '';
        medicineInfo.frequencyController.text = data['frequency'] ?? '';
        medicineInfo.durationController.text = data['duration'] ?? '';

        loadedMedicines.add(medicineInfo);
      }

      setState(() {
        medicinesInfo = loadedMedicines;
      });
    } catch (error) {
      print("Error loading Medicine Details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return medicineFrequencyDurationCard();
  }

  Card medicineFrequencyDurationCard() {
    return Card(
      elevation: 4,
    color: Colors.yellow.shade50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '| MEDICINE ',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 25),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                medicinesInfo.add(MedicineInfo());
              });
            },
          ),
          for (int i = 0; i < medicinesInfo.length; i++)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: medicinesInfo[i].nameController,
                    decoration: InputDecoration(labelText: 'Medicine Name'),
                    onChanged: (_) => onMedicineInputChange(i),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: medicinesInfo[i].frequencyController,
                    decoration: InputDecoration(labelText: 'Frequency'),
                    onChanged: (_) => onMedicineInputChange(i),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: medicinesInfo[i].durationController,
                    decoration: InputDecoration(labelText: 'Duration'),
                    onChanged: (_) => onMedicineInputChange(i),
                  ),
                ),

              ],
            ),
        ],
      ),
    ),
  );
  }
}

class MedicineInfo {
  late final int index;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
}
