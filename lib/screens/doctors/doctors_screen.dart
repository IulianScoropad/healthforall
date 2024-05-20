import 'package:healthforall/components/custom_app_bar.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/models/AvailableDoctor.dart';
import 'package:healthforall/models/DoctorProvider.dart';
import 'package:healthforall/screens/details/doctor_details_screen.dart';
import 'package:flutter/material.dart';

import 'components/docotor_card.dart';

class DoctorsScreen extends StatefulWidget {


  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
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
              CustomAppBar(
                text: "Available",
                title: "Specialist",
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: FutureBuilder<List<AvailableDoctor>>(
                  future: futureDoctors,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No doctors found'));
                    }

                    List<AvailableDoctor> doctors = snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                      ),
                      itemBuilder: (context, index) => DoctorCard(
                        doctor: doctors[index],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(),
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