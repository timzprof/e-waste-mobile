import 'package:ewaste/components/custom_button.dart';
import 'package:ewaste/components/custom_form_field.dart';
import 'package:ewaste/helpers.dart';
import 'package:ewaste/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                        "Login",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF484848),
                            fontWeight: FontWeight.w600,
                            fontSize: 26),
                      ),
                      const SizedBox(height: 20),
                      Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormField(
                                    controller: emailController,
                                    label: "Your E-mail",
                                    type: 'email',
                                    keyboardType: TextInputType.emailAddress,
                                    validationText:
                                        "Please enter a valid email"),
                                const SizedBox(height: 20),
                                CustomFormField(
                                  controller: passwordController,
                                  label: "Password",
                                  obscureText: !_passwordVisible,
                                  obscuringCharacter: '•',
                                  validationText: "Please enter a password",
                                  suffixIcon: IconButton(
                                    iconSize: 22,
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF484848),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ])),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF484848),
                                        fontWeight: FontWeight.w300),
                                    children: [
                                      const TextSpan(
                                          text: "Don't have an account? "),
                                      TextSpan(
                                        text: "Register",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/signup',
                                                    ModalRoute.withName('/'));
                                          },
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF3CB62A)),
                                      ),
                                    ])),
                          )),
                      const SizedBox(height: 20),
                      Center(
                          child: CustomButton(
                              isLoading:
                                  context.watch<AuthProvider>().isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthProvider>()
                                      .login(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((res) {
                                    print("Login Response: $res");
                                    Navigator.of(context).pushNamed('/');
                                  }).catchError((error) {
                                    print("Error Occurred (Login): $error");
                                    HelperFunctions.displayError(
                                        context, error.toString());
                                  });
                                }
                              },
                              backgroundColor: const Color(0xFF3CB62A),
                              foregroundColor: Colors.white,
                              text: "Login"))
                    ]))));
  }
}
