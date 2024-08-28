import 'package:ewaste/components/custom_button.dart';
import 'package:ewaste/components/custom_form_field.dart';
import 'package:ewaste/helpers.dart';
import 'package:ewaste/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final sensorIdController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    sensorIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                        "Register",
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
                                    controller: nameController,
                                    label: "Full Name",
                                    validationText:
                                        "Please enter a valid name"),
                                const SizedBox(height: 20),
                                CustomFormField(
                                    controller: emailController,
                                    label: "Your E-mail",
                                    type: 'email',
                                    keyboardType: TextInputType.emailAddress,
                                    validationText:
                                        "Please enter a valid email"),
                                const SizedBox(height: 20),
                                CustomFormField(
                                    controller: sensorIdController,
                                    label: "Sensor ID",
                                    validationText:
                                        "Please enter a valid sensor ID"),
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
                                const SizedBox(height: 20),
                                CustomFormField(
                                  controller: confirmPasswordController,
                                  label: "Confirm Password",
                                  obscureText: !_confirmPasswordVisible,
                                  obscuringCharacter: '•',
                                  validationText:
                                      "Confirm Password doesn't match the password",
                                  autoValidate:
                                      AutovalidateMode.onUserInteraction,
                                  extraValidation: () {
                                    return passwordController.text !=
                                        confirmPasswordController.text;
                                  },
                                  suffixIcon: IconButton(
                                    iconSize: 22,
                                    icon: Icon(
                                      _confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF484848),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
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
                                          text: "Already have an account? "),
                                      TextSpan(
                                        text: "Log In",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/login',
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
                                      .registerUser(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          sensorId: sensorIdController.text)
                                      .then((res) {
                                    print("Register User Response: $res");

                                    Navigator.of(context).pushNamed('/login');
                                  }).catchError((error) {
                                    print("Error Occurred (Sign Up): $error");
                                    HelperFunctions.displayError(
                                        context, error.toString());
                                  });
                                }
                              },
                              backgroundColor: const Color(0xFF3CB62A),
                              foregroundColor: Colors.white,
                              text: "Register"))
                    ]))));
  }
}
