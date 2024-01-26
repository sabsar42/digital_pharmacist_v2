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
      color: Colors.blue.shade50,
      margin: EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.medicine.brandName,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              subtitle: Text(
                widget.medicine.type,
              ),
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
                    _buildInfoRow("Brand ID", widget.medicine.brandId),
                    _buildInfoRow("Slug", widget.medicine.slug),
                    _buildInfoRow("Dosage Form", widget.medicine.dosageForm),
                    _buildInfoRow("Generic", widget.medicine.generic),
                    _buildInfoRow("Strength", widget.medicine.strength),
                    _buildInfoRow("Manufacturer", widget.medicine.manufacturer),
                    _buildInfoRow(
                        "Package Container", widget.medicine.packageContainer),
                    _buildInfoRow("Package Size", widget.medicine.packageSize),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
