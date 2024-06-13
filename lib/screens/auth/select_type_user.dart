import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthforall/screens/auth/sign_up_medic.dart';
import 'package:healthforall/screens/auth/sign_up_screen.dart';
class SelectTypeUser extends StatelessWidget {
  const SelectTypeUser({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Who are you?",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40
                      ),
                    ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                      onPressed:
                            () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF6CD8D1),
                      ),
                        // Handle button 1 press

                      child: const Text("Patient",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed:
                            () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpMedic(),
                          ),
                        ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xfffea41d),
                      ),

                      child: const Text("Doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
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