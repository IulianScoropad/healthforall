import 'package:healthforall/constants.dart';
import 'package:healthforall/screens/auth/sign_in_screen.dart';
import 'package:healthforall/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../controllers.dart';
import 'components/sign_up_medic_form.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpMedic extends StatelessWidget {
  // It's time to validat the text field

  final _formKey = GlobalKey<FormState>();

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
            // Now it takes 100% of our height
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              )),
                          child: Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SignUpMedicFrom(formKey: _formKey),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //  if (_formKey.currentState!.validate()) {
                          // Sign up form is done
                          // It saved our inputs
                          //_formKey.currentState!.save();
                          Map<String,dynamic> data = {
                            "username": editUserNameController.text.toString(),
                            "mail": editMaileController.text.toString(),
                            "phone": editPhoneNumberController.text.toString(),
                            "password": editPasswordController.text.toString(),
                            "adress": editAdressController.text.toString(),
                            "region": editRegionController.text.toString(),
                            "category": editCategoryController.text.toString(),
                            "hospitalname" : editHospitalNameController.text.toString(),
                            "time": editTimeController.text.toString(),
                            "numberpatienti": editNumberOfPatienceController.text.toString(),
                            "about": editAboutDoctorController.text.toString(),
                            "experienceyears": editYearsExperienceController.text.toString()
                          };
                          dbRef.child("Doctors").push().set(data).then((value){
                            Navigator.of(context).pop();
                          });
                          //   }

                        },
                        child: Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}