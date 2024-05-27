import 'package:healthforall/components/heightlight.dart';
import 'package:healthforall/components/rating.dart';
import 'package:healthforall/models/AvailableDoctor.dart';
import '../../constants.dart';
import 'package:healthforall/screens/appointment/appointment_screen.dart';
import 'package:flutter/material.dart';

import '../../controllers.dart';
import '../../models/SearchDoctor.dart';
import 'components/communication.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final AvailableDoctor doctor;
 const  DoctorDetailsScreen({Key? key, required this.doctor}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    doctorID = doctor.key.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr." + (doctor.username  ?? "") + (doctorID ?? "")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/doctor_big_preview.png"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Communication(),
              ),
              Text(
               doctor.categorie ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(doctor.hospitalname ?? ""),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                child: Rating(score: 5),
              ),
              SizedBox(height: defaultPadding),
              Text(
                "About"+ (doctor.username ?? " "),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Text(
                doctor.despre ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Highlight(
                      name: "Patients",
                      text: doctor.numarpacienti ?? "",
                    ),
                    Highlight(
                      name: "Experience",
                      text: (doctor.experience ?? "") +"Years" ,
                    ),
                    Highlight(
                      name: "Reviews",
                      text: "2.05K",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: ElevatedButton(
                  onPressed: () =>


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AppointmentScreen(),
                      ),
                    )
                    ,

                  child: Text("Book an Appoinment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
