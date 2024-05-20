import 'package:healthforall/components/custom_app_bar.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/models/AvailableDoctor.dart';
import 'package:healthforall/screens/details/doctor_details_screen.dart';
import 'package:flutter/material.dart';

import 'components/docotor_card.dart';

class DoctorsScreen extends StatelessWidget {
  final String userId;

  const DoctorsScreen({Key? key,required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(text: "Available", title: "Specialist", userId: "null",),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: demoAvailableDoctors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                  ),
                  itemBuilder: (context, index) => DoctorCard(
                    doctor: demoAvailableDoctors[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(userId: userId),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
