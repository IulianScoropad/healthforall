import 'package:flutter/material.dart';
import 'package:healthforall/components/available_doctor_card.dart';
import 'package:healthforall/components/section_title.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/models/AvailableDoctor.dart';
import 'package:healthforall/models/DoctorProvider.dart';
import 'package:healthforall/screens/doctors/doctors_screen.dart';

class AvailableDoctors extends StatefulWidget {

  const AvailableDoctors({super.key});

  @override
  _AvailableDoctorsState createState() => _AvailableDoctorsState();
}

class _AvailableDoctorsState extends State<AvailableDoctors> {
  late Future<List<AvailableDoctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = DoctorProvider.fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "Available Doctor",
            pressOnSeeAll: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorsScreen(),
              ),
            ),
          ),
        ),
        FutureBuilder<List<AvailableDoctor>>(
          future: futureDoctors,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }

            List<AvailableDoctor> doctors = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  doctors.length,
                      (index) => Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: AvailableDoctorCard(
                      info: doctors[index],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}