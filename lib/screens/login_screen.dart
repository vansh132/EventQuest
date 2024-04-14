import 'package:eventquest/screens/constants/utils.dart';
import 'package:eventquest/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signInForm = GlobalKey<FormState>();
  final UserService userService = UserService();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  void signIn() {
    userService.signIn(
      context: context,
      username: _username.text,
      password: _password.text,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1B2A),
        title: const Text(
          "EventQuest",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff0D1B2A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30,
                child: Image.asset('assets/images/login_image.png'),
              ),
              Container(
                // color: Colors.red,
                margin: const EdgeInsets.only(left: 24, top: 24),
                padding: const EdgeInsets.all(8),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 1,
                          color: Color(0xfff1faee)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Please sign in to continue.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 2,
                          color: Color(0xff8d99ae)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: signInForm,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 24, right: 24),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffddd5d8),
                      ),
                      child: TextFormField(
                        controller: _username,
                        autofocus: false,
                        style: const TextStyle(
                          color: Color(0xff03071e),
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Register No',
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Color(0xff03071e),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 24, right: 24),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffddd5d8),
                      ),
                      child: TextFormField(
                        controller: _password,
                        autofocus: false,
                        obscureText: true,
                        style: const TextStyle(
                          color: Color(0xff03071e),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xff03071e),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (signInForm.currentState!.validate()) {
                          signIn();
                        }
                      },
                      child: const Icon(
                        size: 48,
                        Icons.arrow_circle_right_rounded,
                        color: Color(0xffACC8E4),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 2,
                            color: Color(0xffACC8E4)),
                      ),
                      onPressed: () {
                        showSnackBar(context,
                            "Under maintainance, contact admin@christuniversity.edu.in for further procedure");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "\" Every moment, a chance for greatness. \"",
                    style: TextStyle(color: Color(0xff8d99ae)),
                    softWrap: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
