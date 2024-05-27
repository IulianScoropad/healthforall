import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthforall/controllers.dart';

import '../../constants.dart';
import 'package:healthforall/screens/home/home_screen.dart';
import 'package:healthforall/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cpmponents/calendar.dart';

class AppointmentScreen extends StatefulWidget {


  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}



class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<String> sloats = [
    "10:10 am",
    "10:30 am",
    "10:50 am",
    "2:10 pm",
    "2:50 pm",
  ];
  late DateTime selectedDate = DateTime.now();
  int selectedSloats = 0;

  Future<void> saveAppointment(Appointment appointment) async {
    final databaseReference = FirebaseDatabase.instance.reference().child("appointments");
    await databaseReference.push().set(appointment.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Calendar( onDateSelected: (DateTime date) {
    setState(() {
    selectedDate = date;
    });
    },),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "Slots",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.77,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSloats = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        selectedSloats == index ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Text(
                    sloats[index],
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color:
                            selectedSloats == index ? Colors.white : textColor),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton(
              onPressed: () async {

                final String doctor = doctorID.toString(); // replace with actual doctor ID
                final String patientId = globalUserId.toString(); // replace with actual patient ID
                 // Replace with actual selected date
                final selectedTime = sloats[selectedSloats];

              //  final appointmentDateTime = DateTime.parse(
              //    "${selectedDate.toIso8601String().split('T').first} ${selectedTime}",
             //   );

                final appointmentDateTime = selectedDate.day.toString() +  '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString() + ' , ' + selectedTime;

                final appointment = Appointment(
                  doctorUID: doctor,
                  patientId: patientId,
                  dateTime: appointmentDateTime,
                );

                await saveAppointment(appointment);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );

              },
              child: Text("Confirm  Appoinment"),
            ),
          ),
        ],
      ),
    );
  }
}


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