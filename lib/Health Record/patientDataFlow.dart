class patientDataFlow {
  DoctorInformation? doctorInformation;
  Diagnosis? diagnosis;
  MedicalSummary? medicalSummary;
  List<String>? prescribedMedicine;
  String? futureAppointmentDate;
  List<String>? additionalNotes;


  patientDataFlow(
      {this.doctorInformation,
        this.diagnosis,
        this.medicalSummary,
        this.prescribedMedicine,
        this.futureAppointmentDate,
        this.additionalNotes});

  patientDataFlow.fromJson(Map<String, dynamic> json) {
    doctorInformation = json['doctorInformation'] != null
        ? new DoctorInformation.fromJson(json['doctorInformation'])
        : null;
    diagnosis = json['diagnosis'] != null
        ? new Diagnosis.fromJson(json['diagnosis'])
        : null;
    medicalSummary = json['medicalSummary'] != null
        ? new MedicalSummary.fromJson(json['medicalSummary'])
        : null;
    prescribedMedicine = json['prescribedMedicine'].cast<String>();
    futureAppointmentDate = json['futureAppointmentDate'];
    additionalNotes = json['additionalNotes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorInformation != null) {
      data['doctorInformation'] = this.doctorInformation!.toJson();
    }
    if (this.diagnosis != null) {
      data['diagnosis'] = this.diagnosis!.toJson();
    }
    if (this.medicalSummary != null) {
      data['medicalSummary'] = this.medicalSummary!.toJson();
    }
    data['prescribedMedicine'] = this.prescribedMedicine;
    data['futureAppointmentDate'] = this.futureAppointmentDate;
    data['additionalNotes'] = this.additionalNotes;
    return data;
  }
}

class DoctorInformation {
  String? name;
  String? address;
  String? phone;
  String? email;

  DoctorInformation({this.name, this.address, this.phone, this.email});

  DoctorInformation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class Diagnosis {
  String? condition;
  String? dateOfDiagnosis;
  String? treatmentPlan;

  Diagnosis({this.condition, this.dateOfDiagnosis, this.treatmentPlan});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    dateOfDiagnosis = json['dateOfDiagnosis'];
    treatmentPlan = json['treatmentPlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['dateOfDiagnosis'] = this.dateOfDiagnosis;
    data['treatmentPlan'] = this.treatmentPlan;
    return data;
  }
}

class MedicalSummary {
  String? height;
  String? weight;
  String? bloodPressure;
  String? pulse;
  String? temperature;

  MedicalSummary(
      {this.height,
        this.weight,
        this.bloodPressure,
        this.pulse,
        this.temperature});

  MedicalSummary.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    bloodPressure = json['bloodPressure'];
    pulse = json['pulse'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bloodPressure'] = this.bloodPressure;
    data['pulse'] = this.pulse;
    data['temperature'] = this.temperature;
    return data;
  }
}
