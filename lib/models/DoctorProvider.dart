import 'package:firebase_database/firebase_database.dart';
import 'package:healthforall/models/AvailableDoctor.dart';

class DoctorProvider {
  static Future<List<AvailableDoctor>> fetchDoctors() async {
    List<AvailableDoctor> doctors = [];

    try {
      final databaseReference = FirebaseDatabase.instance.reference();
      DatabaseEvent event = await databaseReference.child('Doctors').once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> doctorData = snapshot.value as Map<dynamic, dynamic>;
        doctorData.forEach((key, value) {
          doctors.add(AvailableDoctor.fromMap(Map<String, dynamic>.from(value)));
        });
      }
    } catch (error) {
      print("Error fetching doctors: $error");
    }

    return doctors;
  }
}