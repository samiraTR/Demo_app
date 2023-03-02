import 'package:demo_app/Ui/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obsecure = true;
  bool conObsecure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Register Account",
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
                obscureText: obsecure,
                controller: passController,
                decoration: InputDecoration(
                  hintText: "Enter PassWord",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      },
                      icon: obsecure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: conObsecure,
                controller: confirmPassController,
                decoration: InputDecoration(
                  hintText: "Confirm PassWord",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          conObsecure = !conObsecure;
                        });
                      },
                      icon: conObsecure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      (MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      )),
                    );
                    print("Register");
                  },
                  child: const Text("Register")),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: "Already have an Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  const WidgetSpan(
                    child: SizedBox(
                      width: 15,
                    ),
                  ),
                  TextSpan(
                      text: "Login Here",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const LoginScreen())),
                              (Route<dynamic> route) => false);

                          print("VOGAS");
                        })
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
