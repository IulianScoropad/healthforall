import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthforall/screens/home/home_screen_doctor.dart';
class AppointmentPatience {
  final String id;
  final String userId;
  final String doctorId;
  final String date;
  // final String time;
  final String patienceName;
  final String phone;
  final String region;
  final String adress;

  AppointmentPatience({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    // required this.time,
    required this.patienceName,
    required this.phone,
    required this.region,
    required this.adress,
  });

  factory AppointmentPatience.fromMap(String id, Map<dynamic, dynamic> data,
      Map<String, String> pacientDetails) {
    return AppointmentPatience(
      id: id,
      userId: data['patientId'],
      doctorId: data['doctorId'],
      date: data['dateTime'],
      patienceName: pacientDetails['doctorName'] ?? 'Unknown',
      phone: pacientDetails['type'] ?? 'Unknown',
      region: pacientDetails['place'] ?? 'Unknown',
      adress: pacientDetails['adress'] ?? 'Unknown',
    );
  }
}
