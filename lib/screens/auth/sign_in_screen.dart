import 'package:healthforall/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthforall/screens/home/home_screen.dart';
import 'package:healthforall/screens/main/main_screen.dart';
import '../../constants.dart';
import 'components/sign_in_form.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../controllers.dart';

class SignInScreen extends StatelessWidget {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future<void> login(BuildContext context, String email, String password) async{
    final String email = editMaileController.text.trim();
    final String password = editPasswordController.text.trim();


    try{
      DatabaseEvent value = await dbRef.child('Pacienti').orderByChild('mail').equalTo(email).once();
      DataSnapshot snapshot = value.snapshot;
      if (snapshot.value != null){
    Map<dynamic, dynamic> pacienti = snapshot.value as Map<dynamic, dynamic>;
    pacienti.forEach((key, value) {
      if(value['password'] == password){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else{
          errorMessage ='Incorrect password';

        }
    });
  }else {
        errorMessage ='Email not found';

  }
  } catch (e){
      errorMessage = 'An error occurred. Please try again.';

    }
  }
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
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: Text(
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
                          //if (_formKey.currentState!.validate()) {
                            login(context, editMaileController.text.trim(), editPasswordController.text.trim());
                           // _formKey.currentState!.save();
                            //  Sign in also done
                         // }
                        },
                        child: Text("Sign In"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
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
