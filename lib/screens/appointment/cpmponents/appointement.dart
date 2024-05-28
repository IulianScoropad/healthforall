class Appointment {
  final String id;
  final String userId;
  final String doctorId;
  final String date;
 // final String time;
  final String doctorName;
  final String type;
  final String place;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
   // required this.time,
    required this.doctorName,
    required this.type,
    required this.place,
  });

  factory Appointment.fromMap(String id, Map<dynamic, dynamic> data, Map<String, String> doctorDetails) {
    return Appointment(
      id: id,
      userId: data['patientId'],
      doctorId: data['doctorId'],
      date: data['dateTime'],
      doctorName: doctorDetails['doctorName'] ?? 'Unknown',
      type: doctorDetails['type'] ?? 'Unknown',
      place: doctorDetails['place'] ?? 'Unknown',
    );
  }
}