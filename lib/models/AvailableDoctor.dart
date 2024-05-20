import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AvailableDoctor {
  final String?  username,experience, time, region, phone, numarpacienti, mail, hospitalname, categorie, adresa, despre, image;
   Key? key;

  AvailableDoctor({
 this.key,
    this.experience,
    this.username,
    this.time,
    this.region,
    this.phone,
    this.numarpacienti,
    this.mail,
    this.hospitalname,
    this.categorie,
    this.adresa,
    this.despre,
    this.image
  });


  factory AvailableDoctor.fromMap(Map<dynamic, dynamic> data) {
   // Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

    return AvailableDoctor(
      username: data?['username'],
      region: data?['region'],
      experience: data?['experienceyears'],
      numarpacienti: data?['numberpatienti'],
      time: data?['time'],
      phone: data?['phone'],
      mail: data?['mail'],
      hospitalname: data?['hospitalname'],
      adresa: data?['adress'],
      despre: data?['about'],
      image: "assets/images/Serena_Gome.png",
      categorie: "category"
    );
  }
}

