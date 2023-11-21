

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicalAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Icon(Icons.account_circle), // App logo or user icon
            Text(
              'Medical App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Spacer(),
            Icon(Icons.search), // Search bar
            Icon(Icons.account_circle), // Profile icon
          ],
        ),
      ),
      body: ListView(
        children: [
          MedicalHistorySection(),
          MedicineSection(),
        ],
      ),
    );
  }
}

class MedicalHistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Medical History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        // Medical history list
        MedicalRecordTile(),
        MedicalRecordTile(),
        MedicalRecordTile(),
      ],
    );
  }
}

class MedicalRecordTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Type of Record'),
      subtitle: Text('Date: DD/MM/YYYY'),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Handle navigation to medical record details
      },
    );
  }
}

class MedicineSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Medicine',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        // Medicine list
        MedicineTile(),
        MedicineTile(),
        MedicineTile(),
      ],
    );
  }
}

class MedicineTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Medicine Name'),
      subtitle: Text('Dosage: X mg | Frequency: Y times/day'),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Handle navigation to medicine details
      },
    );
  }
}
