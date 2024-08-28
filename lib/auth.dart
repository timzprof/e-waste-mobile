import 'package:ewaste/components/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Collect!",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF484848),
                            fontWeight: FontWeight.w600,
                            fontSize: 26),
                      ),
                      const Text(
                        "Track!",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF3CB62A),
                            fontWeight: FontWeight.w600,
                            fontSize: 26),
                      ),
                      const Text(
                        "Dispose!",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF484848),
                            fontWeight: FontWeight.w600,
                            fontSize: 26),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome back to E-Waste Mobile App",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF484848),
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                      Container(
                          height: 250,
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/eco.jpg'),
                                  fit: BoxFit.contain))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            backgroundColor: const Color(0XFFF5F5F5),
                            foregroundColor: const Color(0xFF484848),
                            textColor: const Color(0xFF484848),
                            text: "Register",
                            minimumSize: const Size(160, 80),
                            fontSize: 20,
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            backgroundColor: const Color(0XFFF5F5F5),
                            foregroundColor: const Color(0xFF484848),
                            textColor: const Color(0xFF484848),
                            text: "Sign In",
                            minimumSize: const Size(160, 80),
                            fontSize: 20,
                          ),
                        ],
                      )
                    ]))));
  }
}
