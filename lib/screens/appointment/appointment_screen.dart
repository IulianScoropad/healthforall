import 'package:firebase_database/firebase_database.dart';
import 'package:healthforall/controllers.dart';
import '../../constants.dart';
import 'package:healthforall/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'components/Appointment.dart';
import 'components/calendar.dart';

class AppointmentScreen extends StatefulWidget {


  const AppointmentScreen({super.key});

  @override
  AppointmentScreenState createState() => AppointmentScreenState();
}



class AppointmentScreenState extends State<AppointmentScreen> {
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
    final databaseReference = FirebaseDatabase.instance.ref().child("appointments");
    await databaseReference.push().set(appointment.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment"),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
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

                final String doctor = doctorID.toString();
                final String patientId = globalUserId.toString();
                final selectedTime = sloats[selectedSloats];
                final appointmentDateTime = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} , $selectedTime';
                final appointment = Appointment(
                  doctorUID: doctor,
                  patientId: patientId,
                  dateTime: appointmentDateTime,
                );

                await saveAppointment(appointment);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );

              },
              child: const Text("Confirm  Appoinment"),
            ),
          ),
        ],
      ),
    );
  }
}


