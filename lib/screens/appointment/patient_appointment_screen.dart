import '../../constants.dart';
import '../../controllers.dart';
import 'package:flutter/material.dart';
import 'package:healthforall/screens/appointment/components/AppointementCardDoctor.dart';
import 'package:firebase_database/firebase_database.dart';


class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  MyAppointmentScreenState createState() => MyAppointmentScreenState();
}


  class MyAppointmentScreenState extends State<MyAppointmentScreen> {

  Future<List<AppointmentDoctor>> fetchAppointments() async {
    final databaseReference = FirebaseDatabase.instance.ref().child("appointments");
    final value = await databaseReference.orderByChild('patientId').equalTo(globalUserId).once();
    final snapshotD = value.snapshot;
    List<AppointmentDoctor> appointments = [];
    if (snapshotD.value != null && snapshotD.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> values = snapshotD.value as Map<dynamic, dynamic>;
      for (var key in values.keys) {
        var value = values[key];
        if (value is Map<dynamic, dynamic>) {
          Map<String, String> doctorDetails = await getDoctorDetails(value['doctorId']);
          AppointmentDoctor appointment = AppointmentDoctor.fromMap(
            key,
            value,
            doctorDetails,
          );
          appointments.add(appointment);
        }
      }
    }
    return appointments;
  }

  Future<Map<String, String>> getDoctorDetails(String doctorId) async {
    final doctorReference = FirebaseDatabase.instance.ref().child("Doctors").child(doctorId);
    final value = await doctorReference.once();
    final snapshot = value.snapshot;
    if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return {
        'doctorName': data['username'] ?? 'Unknown',
        'type': data['category'] ?? 'Unknown',
        'place': data['hospitalname'] ?? 'Unknown',
      };
    } else {
      return {
        'doctorName': 'Unknown',
        'type': 'Unknown',
        'place': 'Unknown',
      };
    }
  }
  
  Future<void> deleteAppointment(String appointmentId) async {
    final databaseReference = FirebaseDatabase.instance.ref().child("appointments").child(appointmentId);
    await databaseReference.remove();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Appointments"),
      ),
      body: FutureBuilder<List<AppointmentDoctor>>(
        future: fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No appointments found"));
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: snapshot.data!.map((appointment) => _buildAppointmentCard(appointment)).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentDoctor appointment) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(bottom: defaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildAppointmentInfo("Date", appointment.date),
              ),

              Expanded(
                child: buildAppointmentInfo("Doctor", appointment.doctorName),
              ),
            ],
          ),
          const Divider(height: defaultPadding * 2),
          Row(
            children: [
              Expanded(
                child: buildAppointmentInfo(
                  "Type",
                  appointment.type,
                ),
              ),
              Expanded(
                child: buildAppointmentInfo("Place", appointment.place),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async{
                    await deleteAppointment(appointment.id);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}