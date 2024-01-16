import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHospitalInformation extends StatelessWidget {
  const DoctorHospitalInformation({
    super.key,
    required TextEditingController doctorNameController,
    required TextEditingController specializationController,
    required TextEditingController hospitalNameController,
  }) : _doctorNameController = doctorNameController, _specializationController = specializationController, _hospitalNameController = hospitalNameController;

  final TextEditingController _doctorNameController;
  final TextEditingController _specializationController;
  final TextEditingController _hospitalNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              12.0),
        ),
        color: Colors.orange.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset('assets/images/doctor.png',
                      height: 40, width: 40),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DOCTOR NAME",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 250,
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          controller: _doctorNameController,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Doctor ',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.assignment_ind, size: 30),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specialization",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 250,
                        height: 40,
                        child: TextField(
                          maxLines: 1,
                          controller: _specializationController,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Specialized In',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital_outlined,
                    size: 30,
                    color: Colors.pink,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hospital / Clinic Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 250,
                        height: 40,
                        child: TextField(
                          maxLines: 1,
                          controller: _hospitalNameController,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Hospita / Clinic Name',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}