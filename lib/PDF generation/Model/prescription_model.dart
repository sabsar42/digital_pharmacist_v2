class PrescriptionModel {
  final String patientName;
  final String patientAddress;
  final String doctorName;
  final List<Medication> medications;

  PrescriptionModel({
    required this.patientName,
    required this.patientAddress,
    required this.doctorName,
    required this.medications,
  });

}

class Medication {
  final String medicationName;
  final String dosage;

  Medication(this.medicationName, this.dosage);


}
