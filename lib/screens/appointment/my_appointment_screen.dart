import '../../constants.dart';
import '../../controllers.dart';
import 'package:flutter/material.dart';
import 'package:healthforall/screens/appointment/cpmponents/appointement.dart';
import 'package:firebase_database/firebase_database.dart';


class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}


  class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  Future<List<Appointment>> _fetchAppointments() async {
    final databaseReference = FirebaseDatabase.instance.reference().child("appointments");
    final value = await databaseReference.orderByChild('patientId').equalTo(globalUserId).once();
    final snapshotD = value.snapshot;
    List<Appointment> appointments = [];
    if (snapshotD.value != null && snapshotD.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> values = snapshotD.value as Map<dynamic, dynamic>;
      for (var key in values.keys) {
        var value = values[key];
        if (value is Map<dynamic, dynamic>) {
          Map<String, String> doctorDetails = await getDoctorDetails(value['doctorId']);
          Appointment appointment = Appointment.fromMap(
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
    final doctorReference = FirebaseDatabase.instance.reference().child("Doctors").child(doctorId);
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
  Future<void> _deleteAppointment(String appointmentId) async {
    final databaseReference = FirebaseDatabase.instance.reference().child("appointments").child(appointmentId);
    await databaseReference.remove();
    // Reîmprospătarea listei de programări după ștergere
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Appointments"),
      ),
      body: FutureBuilder<List<Appointment>>(
        future: _fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No appointments found"));
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: snapshot.data!.map((appointment) => _buildAppointmentCard(appointment)).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      margin: EdgeInsets.only(bottom: defaultPadding),
      decoration: BoxDecoration(
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
          Divider(height: defaultPadding * 2),
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
                    await _deleteAppointment(appointment.id);
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildAppointmentInfo(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(0.62),
          ),
        ),
        Text(
          text,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}