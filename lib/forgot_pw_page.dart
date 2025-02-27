import 'package:authapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  Future passwordReset() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email to reset your password",
            textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

            //email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: emailController,
              hintText: "Enter email",
              obscureText: false,
          ),
        ),

          const SizedBox(
            height: 10,
          ),
          //reset password button
          MaterialButton(onPressed: passwordReset,
          child: const Text("Reset Password",
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
          ),
          color: Colors.black,
          ),
        ],
      )
    );
  }
}