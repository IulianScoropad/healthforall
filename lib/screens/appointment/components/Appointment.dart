
class Appointment {
  final String doctorUID;
  final String patientId;
  final String dateTime;

  Appointment({
    required this.doctorUID,
    required this.patientId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorUID,
      'patientId': patientId,
      'dateTime': dateTime,
    };
  }
}