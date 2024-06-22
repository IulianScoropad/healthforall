import 'package:flutter/material.dart';

final TextEditingController editUserNameController = TextEditingController();
final TextEditingController editMaileController = TextEditingController();
final TextEditingController editPhoneNumberController = TextEditingController();
final TextEditingController editPasswordController = TextEditingController();
final TextEditingController editAdressController = TextEditingController();
final TextEditingController editRegionController = TextEditingController();
final TextEditingController editCategoryController = TextEditingController();
final TextEditingController editHospitalNameController = TextEditingController();
final TextEditingController editTimeController = TextEditingController();
final TextEditingController editNumberOfPatienceController = TextEditingController();
final TextEditingController editAboutDoctorController = TextEditingController();
final TextEditingController editYearsExperienceController = TextEditingController();

String? globalUserId;
String? doctorID;
String? globalSelectedRegion;
String? globalSelectedCategory;
DateTime? globalSelectedDate;
String doctorCategory = '';