import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthforall/screens/appointment/components/AppointmentCardPatient.dart';
import 'package:healthforall/chat/chat.dart';

import '../../constants.dart';
import '../../controllers.dart';

class HomeScreenDoctor extends StatefulWidget {
  const HomeScreenDoctor({super.key});

  @override
  _HomeScreenDoctor createState() => _HomeScreenDoctor();
}
String getChatId(String doctorId, String userId) {
  return '${doctorId}_$userId';
}

class _HomeScreenDoctor extends State<HomeScreenDoctor> {
  Future<List<AppointmentPatience>> _fetchAppointments() async {
    final databaseReference = FirebaseDatabase.instance.ref().child(
        "appointments");
    final value = await databaseReference.orderByChild('doctorId').equalTo(
        globalUserId).once();
    final snapshotD = value.snapshot;
    List<AppointmentPatience> appointments = [];
    if (snapshotD.value != null && snapshotD.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> values = snapshotD.value as Map<dynamic, dynamic>;
      for (var key in values.keys) {
        var value = values[key];
        if (value is Map<dynamic, dynamic>) {
          Map<String, String> pacientDetails = await getPacientDetails(
              value['patientId']);
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
    final doctorReference = FirebaseDatabase.instance.ref()
        .child("Pacienti")
        .child(pacientId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Appointments"),
      ),
      body: FutureBuilder<List<AppointmentPatience>>(
        future: _fetchAppointments(),
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
                children: snapshot.data!.map((appointment) =>
                    _buildAppointmentCard(appointment)).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentPatience appointment) {
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
                child: buildAppointmentInfo(
                    "Pacient", appointment.patienceName),
              ),

              Expanded(
                child: buildAppointmentInfo("Date", appointment.date,),
              ),
            ],
          ),
          const Divider(height: defaultPadding * 2),
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
              const SizedBox(width: defaultPadding / 2),
              Expanded(
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFFFBA351).withOpacity(0.75),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(chatId: getChatId(
                                globalUserId!, appointment.userId),
                              userId: globalUserId!,),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Chat.svg",
                    width: 11,
                  ),
                  label: const Text("Message"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



