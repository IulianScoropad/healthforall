import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';
import '../../../controllers.dart';

class DropdownController {
  ValueNotifier<String> _valueNotifier;

  DropdownController(String initialValue)
      : _valueNotifier = ValueNotifier<String>(initialValue);

  String get value => _valueNotifier.value;

  set value(String newValue) {
    _valueNotifier.value = newValue;
  }

  ValueNotifier<String> get notifier => _valueNotifier;
}


class SignUpMedicFrom extends StatelessWidget {

  SignUpMedicFrom({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;
  final DropdownController dropdownController = DropdownController('Alba');
  final DropdownController dropdownControllerMedic = DropdownController('Pediatrician');

  late String _userName, _email, _password, _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Username"),
          TextFormField(
            controller: editUserNameController,
            decoration: InputDecoration(hintText: "theflutterway"),
            validator: RequiredValidator(errorText: "Username is required"),
            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),
          // We will fixed the error soon
          // As you can see, it's a email field
          // But no @ on keybord
          TextFieldName(text: "Email"),
          TextFormField(
            controller: editMaileController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Phone"),
          // Same for phone number
          TextFormField(
            controller: editPhoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "+123487697"),
            validator: RequiredValidator(errorText: "Phone number is required"),
            onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Region"),
          // Same for phone number
          ValueListenableBuilder<String>(
            valueListenable: dropdownController.notifier,
            builder:(context, value, child) {
              return DropdownButton<String>(
                value: value,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    dropdownController.value = value;
                    editRegionController.text = dropdownController.value;
                  }
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Adresss"),
          // Same for phone number
          TextFormField(
            controller: editAdressController,
            decoration: InputDecoration(hintText: "adress"),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Caterory"),
          // Same for phone number
          ValueListenableBuilder<String>(
            valueListenable: dropdownControllerMedic.notifier,
            builder:(context, value, child) {
              return DropdownButton<String>(
                value: value,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    dropdownControllerMedic.value = value;
                    editCategoryController.text = dropdownControllerMedic.value;
                  }
                },
                items: categoryList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Hospital Name"),
          // Same for phone number
          TextFormField(
            controller: editHospitalNameController,
            decoration: InputDecoration(hintText: "hospitalName"),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Time"),
          // Same for phone number
          TextFormField(
            controller: editTimeController,
            decoration: InputDecoration(hintText: "time"),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Number of Patients"),
          // Same for phone number
          TextFormField(
            controller: editNumberOfPatienceController,
            decoration: InputDecoration(hintText: "number"),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "About you"),
          // Same for phone number
          TextFormField(
            controller: editAboutDoctorController,
            decoration: InputDecoration(hintText: "About"),
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Confirm Password"),
          TextFormField(
            controller: editPasswordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "*****"),
            validator: (pass) => MatchValidator(errorText: "Password do not  match").validateMatch(pass!, _password),
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
