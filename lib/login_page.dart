import 'package:authapp/forgot_pw_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authapp/components/my_button.dart';
import 'package:authapp/components/my_textfield.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  //sign user in method
  void signUserIn() async{

    //show loading circle
    showDialog(
      context: context, 
      builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  );


    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //pop the loading circle
      Navigator.pop(context);

    } 
    on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 197, 33, 21),
          title: Center(
            child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
         ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const SizedBox(
              height: 50,
            ),

            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(
              height: 50,
              ),
        
            //welcome back you've been missed
            Text(
              "Welcome back you\'ve been missed!",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16),
              ),

            const SizedBox(
              height: 25,
              ),
            //email textfield
            MyTextField(
              controller: emailController,
              hintText: "Enter email",
              obscureText: false,
            ),

            const SizedBox(
              height: 25,
              ),
        
            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: "Enter Password",
              obscureText: true,
            ),

            const SizedBox(
              height: 10
              ),

            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordPage();
                    }
                  )
                );
              },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25
              ),
            //signin button
            MyButton(
              text: "Sign In",
              onTap: signUserIn,
            ),

            const SizedBox(
              height: 25,
              ),

            //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                style: TextStyle(
                  color: Colors.grey[700]
                ),
              ),
                const SizedBox(
                  width: 4
                  ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Register Now ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ],
            )
          ], 
         ),
        ),
       ),
      ),
    );
  }
}