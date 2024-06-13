import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../controllers.dart';
import '../../../constants.dart';
import 'sign_up_patient_form.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey formKey;



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Email"),
          TextFormField(
            controller: editMaileController,
            keyboardType: TextInputType.emailAddress,
            validator: EmailValidator(errorText: "Use a valid email!").call,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Password"),
          TextFormField(
            controller: editPasswordController,
            obscureText: true,
            validator: passwordValidator.call,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
