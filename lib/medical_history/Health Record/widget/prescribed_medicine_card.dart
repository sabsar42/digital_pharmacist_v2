import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrescribedMedicineCard extends StatelessWidget {
  const PrescribedMedicineCard({
    super.key,
    required this.prescribedMedicines,
  });

  final List prescribedMedicines;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| Prescribed Medicines",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              itemExtent: 37.0,
              shrinkWrap: true,
              itemCount: prescribedMedicines.length,
              itemBuilder: (context, index) {
                return ListTile(

                  leading: CircleAvatar(
                    radius: 12,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    prescribedMedicines[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
