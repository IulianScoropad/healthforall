import 'package:healthforall/constants.dart';
import 'package:healthforall/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers.dart';
import 'components/sign_up_medic_form.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpMedic extends StatelessWidget {


  final _formKey = GlobalKey<FormState>();

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  SignUpMedic({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
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
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              )),
                          child: const Text(
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


                        },
                        child: const Text("Sign Up"),
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