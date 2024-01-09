import 'package:flutter/material.dart';

class MedInfoCard extends StatelessWidget {
  const MedInfoCard({
    Key? key,
    required TextEditingController diagnosisController,
    required String title,
  })  : _diagnosisController = diagnosisController,
        _title = title,
        super(key: key);

  final TextEditingController _diagnosisController;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              maxLines: null,
              controller: _diagnosisController,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
