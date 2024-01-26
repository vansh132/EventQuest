import 'package:eventquest/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/sign-up-screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // AuthServices authServices = AuthServices();
  final _signUpKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  void onSubmit() {
    // authServices.signUpUser(
    //   context: context,
    //   fullName: _fullName.text,
    //   college: _college.text,
    //   phoneNo: int.parse(_phoneNumber.text),
    //   email: _email.text,
    //   password: _password.text,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF03071E),
      // appBar: AppBar(
      //   title: Text('Sign Up'),
      //   // backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _signUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                topBar(),
                const SizedBox(
                  height: 36,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Create an account",
                        style: TextStyle(
                          color: Color(0xFF03071E),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Get ready to embark on an extraordinary journey",
                        style: TextStyle(
                          color: Color(0xFF03071E),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email_rounded),
                      prefixIconColor: Color(0xFF03071E),
                      hintText: "Register No",
                      hintStyle: TextStyle(
                        color: Color(0xFF03071E),
                        fontSize: 14,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF03071E),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _password,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.password_outlined),
                      prefixIconColor: Color(0xFF03071E),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Color(0xFF03071E),
                        fontSize: 14,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF03071E),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty || val.length < 6) {
                        return 'Minimum six character of password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _confirmPassword,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.password_rounded),
                      prefixIconColor: Color(0xFF03071E),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Color(0xFF03071E),
                        fontSize: 14,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFF03071E),
                      ),
                    ),
                    validator: (val) {
                      if (val.toString() != _password.text) {
                        return 'Password not matched';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    style: modernElevatedButtonStyle,
                    onPressed: () {
                      if (_signUpKey.currentState!.validate()) {
                        onSubmit();
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Color(0xFF03071E),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 108,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginScreen.routeName, (route) => false);
                            },
                            child: const Text(
                              "Login ",
                              style: TextStyle(
                                color: Color(0xFF03071E),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
          color: Color(0xff03071e),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(96),
            bottomRight: Radius.circular(96),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 72,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 16,
              ),
              Text(
                "EventQuest",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            child: const Text(
              "Welcome to a world of endless opportunities",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            child: const Text(
              "your adventure begins here!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  final ButtonStyle modernElevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xFF03071E),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
