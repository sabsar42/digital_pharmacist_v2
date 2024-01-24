import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/medicine_model.dart';

class MedicineCard extends StatefulWidget {
  final MedicineModel medicine;

  MedicineCard({required this.medicine});

  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Text(widget.medicine.brandName),
              subtitle: Text(widget.medicine.type),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
            if (isExpanded)
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Brand ID: ${widget.medicine.brandId}"),
                    Text("Slug: ${widget.medicine.slug}"),
                    Text("Dosage Form: ${widget.medicine.dosageForm}"),
                    Text("Generic: ${widget.medicine.generic}"),
                    Text("Strength: ${widget.medicine.strength}"),
                    Text("Manufacturer: ${widget.medicine.manufacturer}"),
                    Text("Package Container: ${widget.medicine.packageContainer}"),
                    Text("Package Size: ${widget.medicine.packageSize}"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}