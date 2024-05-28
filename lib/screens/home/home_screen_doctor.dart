import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthforall/screens/home/components/appointment_card_doctor.dart';
import 'package:healthforall/chat/chat.dart';

import '../../constants.dart';
import '../../controllers.dart';

class HomeScreenDoctor extends StatefulWidget {
  const HomeScreenDoctor({Key? key}) : super(key: key);

  @override
  _HomeScreenDoctor createState() => _HomeScreenDoctor();
}


class _HomeScreenDoctor extends State<HomeScreenDoctor> {
  Future<List<AppointmentPatience>> _fetchAppointments() async {
    final databaseReference = FirebaseDatabase.instance.reference().child("appointments");
    final value = await databaseReference.orderByChild('doctorId').equalTo(globalUserId).once();
    final snapshotD = value.snapshot;
    List<AppointmentPatience> appointments = [];
    if (snapshotD.value != null && snapshotD.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> values = snapshotD.value as Map<dynamic, dynamic>;
      for (var key in values.keys) {
        var value = values[key];
        if (value is Map<dynamic, dynamic>) {
          Map<String, String> pacientDetails = await getPacientDetails(value['patientId']);
          AppointmentPatience appointment = AppointmentPatience.fromMap(
            key,
            value,
            pacientDetails,
          );
          appointments.add(appointment);
        }
      }
    }
    return appointments;
  }

  Future<Map<String, String>> getPacientDetails(String pacientId) async {
    final doctorReference = FirebaseDatabase.instance.reference().child("Pacienti").child(pacientId);
    final value = await doctorReference.once();
    final snapshot = value.snapshot;
    if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return {
        'doctorName': data['username'] ?? 'Unknown',
        'type': data['phone'] ?? 'Unknown',
        'place': data['region'] ?? 'Unknown',
        'adress': data['adress']
      };
    } else {
      return {
        'doctorName': 'Unknown',
        'type': 'Unknown',
        'place': 'Unknown',
        'adress': 'Unknown',
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
      body: FutureBuilder<List<AppointmentPatience>>(
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

  Widget _buildAppointmentCard(AppointmentPatience appointment) {
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
                child: buildAppointmentInfo("Pacient", appointment.patienceName),
              ),

              Expanded(
                child: buildAppointmentInfo("Date", appointment.date,),
              ),
            ],
          ),
          Divider(height: defaultPadding * 2),
          Row(
            children: [
              Expanded(
                child: buildAppointmentInfo(
                  "Adress",
                  appointment.adress,
                ),
              ),
              Expanded(
                child: buildAppointmentInfo("Region", appointment.region),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFFFBA351).withOpacity(0.75),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(chatId: getChatId(globalUserId!, appointment.userId),
                          userId: globalUserId!,),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Chat.svg",
                    color: Colors.white,
                    width: 11,
                  ),
                  label: Text("Message"),
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

  String getChatId(String doctorId, String userId) {
    // Generate a chat ID based on doctorId and userId
    return doctorId + '_' + userId;
  }


