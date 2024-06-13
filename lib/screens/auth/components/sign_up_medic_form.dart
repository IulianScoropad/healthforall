import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../constants.dart';
import '../../../controllers.dart';

class DropdownController {
  final ValueNotifier<String> _valueNotifier;

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
    super.key,
    required this.formKey,
  });

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
          const TextFieldName(text: "Username"),
          TextFormField(
            controller: editUserNameController,
            validator: RequiredValidator(errorText: "Username is required").call,
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Email"),
          TextFormField(
            controller: editMaileController,
            keyboardType: TextInputType.emailAddress,
            validator: EmailValidator(errorText: "Use a valid email!").call,
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Phone"),

          TextFormField(
            controller: editPhoneNumberController,
            keyboardType: TextInputType.phone,
            validator: RequiredValidator(errorText: "Phone number is required").call,
            onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Region"),

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
          const TextFieldName(text: "Adresss"),

          TextFormField(
            controller: editAdressController,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Ani Experienta"),

          TextFormField(
            controller: editYearsExperienceController,
            keyboardType: TextInputType.number,
            validator: RequiredValidator(errorText: "Value is not number").call,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Caterory"),

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
          const TextFieldName(text: "Hospital Name"),
          // Same for phone number
          TextFormField(
            controller: editHospitalNameController,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Time"),
          // Same for phone number
          TextFormField(
            controller: editTimeController,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Number of Patients"),

          TextFormField(
            controller: editNumberOfPatienceController,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "About you"),

          TextFormField(
            controller: editAboutDoctorController,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Password"),
          TextFormField(
            obscureText: true,
            validator: passwordValidator.call,
            onSaved: (password) => _password = password!,
            onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Confirm Password"),
          TextFormField(
            controller: editPasswordController,
            obscureText: true,
            validator: (pass) => MatchValidator(errorText: "Password do not  match").validateMatch(pass!, _password),
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
