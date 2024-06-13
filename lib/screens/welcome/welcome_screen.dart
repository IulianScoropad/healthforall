import 'package:healthforall/constants.dart';
import 'package:healthforall/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthforall/screens/auth/select_type_user.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/splash_bg-optimized.svg"),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/logo.svg",
                    height: 300,
                    width:300,
                  ),
                  const Spacer(),
                  // As you can see we need more paddind on our btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectTypeUser(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xfffea41d),
                      ),
                      child: const Text(
                          "Registration",
                        style: TextStyle(
                            color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            )),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF6CD8D1),
                        ),
                        child: const Text(
                            "Login",
                        style: TextStyle(
                          color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
