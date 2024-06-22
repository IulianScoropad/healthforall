import 'package:healthforall/screens/auth/select_type_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthforall/screens/main/main_screen.dart';
import '../../constants.dart';
import 'components/sign_in_form.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../controllers.dart';
import 'package:healthforall/screens/appointment/doctor_appointment_screen.dart';

class SignInScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  String userId = '';

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  SignInScreen({super.key});

  Future<void> login(BuildContext context, String email, String password) async{

    try{
      DatabaseEvent value = await dbRef.child('Pacienti').orderByChild('mail').equalTo(email).once();
      DataSnapshot snapshot = value.snapshot;
      if (snapshot.value != null){
    Map<dynamic, dynamic> pacienti = snapshot.value as Map<dynamic, dynamic>;
    bool foundUser = false;
    pacienti.forEach((key, value) {
      if(value['password'] == password){
        globalUserId = key;
        foundUser = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
       );
      } else{
          errorMessage ='Parolă incorectă';
        }
    });
    if (!foundUser) {
      errorMessage = 'Utilizatorul nu a fost găsit!';
    }
      } else {
        value = await dbRef.child('Doctors').orderByChild('mail').equalTo(email).once();
        snapshot = value.snapshot;
        if (snapshot.value != null) {
          Map<dynamic, dynamic> doctori = snapshot.value as Map<dynamic,
              dynamic>;
          bool foundUser = false;
          doctori.forEach((key, value) {
            if (value['password'] == password) {
              globalUserId = key;
              foundUser = true;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreenDoctor() ),
              );

            } else {
              errorMessage = 'Parolă incorectă';
            }
          });
          if (!foundUser) {
            errorMessage = 'Utilizatorul nu a fost găsit!';
          }
        } else {
          errorMessage = 'Email invalid';
        }
      }
  } catch (e){
      errorMessage = 'An error occurred. Please try again.';
    }
  }
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
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectTypeUser(),
                            ),
                          ),
                          child: const Text(
                            "Sign Up!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    SignInForm(formKey: _formKey),
                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                            login(context, editMaileController.text, editPasswordController.text);
                        },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF6CD8D1),
                          ),
                        child: const Text("Sign In"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
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
