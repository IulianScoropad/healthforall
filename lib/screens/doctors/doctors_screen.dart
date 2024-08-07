import 'package:healthforall/components/custom_app_bar.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/screens/doctors/components/AvailableDoctor.dart';
import 'package:healthforall/screens/doctors/components/DoctorProvider.dart';
import 'package:healthforall/screens/doctorDetails/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'components/docotor_card.dart';

class DoctorsScreen extends StatefulWidget {


  const DoctorsScreen({super.key});

  @override
  DoctorsScreenState createState() => DoctorsScreenState();
}

class DoctorsScreenState extends State<DoctorsScreen> {
  late Future<List<AvailableDoctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = DoctorProvider.fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(
                text: "Available",
                title: "Specialist",
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: FutureBuilder<List<AvailableDoctor>>(
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
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                      ),
                      itemBuilder: (context, index) => DoctorCard(
                        doctor: doctors[index],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(doctor: doctors[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}