class AppointmentDoctor {
  final String id;
  final String userId;
  final String doctorId;
  final String date;
  final String doctorName;
  final String type;
  final String place;

  AppointmentDoctor({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.doctorName,
    required this.type,
    required this.place,
  });

  factory AppointmentDoctor.fromMap(String id, Map<dynamic, dynamic> data, Map<String, String> doctorDetails) {
    return AppointmentDoctor(
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