import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// I will explain it later

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

const List<String> list = <String>['Alba', 'Arad', 'Argeş', 'Bacău', 'Bihor', 'Bistriţa-Năsăud', 'Botoşani', 'Brăila', 'Braşov',
  'Bucureşti', 'Călăraşi', 'Caraş-Severin', 'Cluj', 'Constanţa', 'Covasna', 'Dâmboviţa', 'Dolj', '	Galaţi', 'Giurgiu', 'Gorj'
  , 'Harghita', 'Hunedoara', 'Ialomiţa', 'Iaşi', 'Ilfov', 'Maramureş', 'Mehedinţi', 'Mureş', 'Neamţ', 'Olt', 'Prahova'
  , 'Sălaj', 'Satu Mare', 'Sibiu', 'Suceava', 'Teleorman', 'Timiş', 'Tulcea', 'Vâlcea', 'Vaslui', 'Vrancea'];

const List<String> categoryList = <String>['Pediatrician', 'Neurosurgeon','Cardiologist','Psychiatrist'];

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);


