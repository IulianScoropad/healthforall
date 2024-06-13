import 'package:healthforall/constants.dart';
import 'package:healthforall/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers.dart';
import 'components/sign_up_form.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  SignUpScreen({super.key});
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
                    SignUpForm(formKey: _formKey),
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
                            };
                            dbRef.child("Pacienti").push().set(data).then((value){
                              Navigator.of(context).pop();
                            });
                       //   }

                        },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xfffea41d),
                          ),
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

