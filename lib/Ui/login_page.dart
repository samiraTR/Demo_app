import 'package:demo_app/Services/api_repository.dart';
import 'package:demo_app/Ui/graph_home_page.dart';
import 'package:demo_app/Ui/homepage.dart';
import 'package:demo_app/Ui/register_page.dart';
import 'package:demo_app/bloc/DictionaryBloc/dictionary_bloc_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passObsecure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  // textInputAction:  TextInputAction.,
                  controller: emailController,
                  decoration:
                      const InputDecoration(hintText: "Enter Email Address"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: passObsecure,
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: "Enter PassWord",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passObsecure = !passObsecure;
                          });
                        },
                        icon: passObsecure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => MyHomePage())),
                          (Route<dynamic> route) => false);
                      print("login");
                    },
                    child: const Text("Login")),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "Need an Account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    const WidgetSpan(
                      child: SizedBox(
                        width: 15,
                      ),
                    ),
                    TextSpan(
                        text: "Register Here",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              )),
                            );
                          })
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
