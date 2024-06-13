import 'package:firebase_database/firebase_database.dart';

class RecommendedDoctor {
  final String name, speciality, institute, image;

  const RecommendedDoctor({
    required this.name,
    required this.speciality,
    required this.institute,
    required this.image,
  });
}

class RecommendedDoctorService {
  List<RecommendedDoctor> recommendedDoctors = [];
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('Doctors');

  Future<List<RecommendedDoctor>> getRecommendedDoctors() async {


    try {
      DatabaseEvent value = await _database.once();
      final snapshot = value.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> doctorsData = snapshot.value as Map<dynamic, dynamic>;
        doctorsData.forEach((key, value) {
          String name = value['username'];
          String speciality = value['category'];
          String institute = value['hospitalname'];
          String image = "assets/images/doctor_photo.png";
          String experienceAsString = value['experienceyears'];
          int experience = int.parse(experienceAsString);
          if (experience >= 10) {
            RecommendedDoctor doctor = RecommendedDoctor(
              name: name,
              speciality: speciality,
              institute: institute,
              image: image,
            );
            recommendedDoctors.add(doctor);
          }
        });
      }
    } catch (error) {
      print('Error fetching recommended doctors: $error');
    }

    return recommendedDoctors;
  }
}