import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authapp/components/my_button.dart';
import 'package:authapp/components/my_textfield.dart';
import 'package:random_string/random_string.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void _showconfirmDialog(BuildContext context) {
    showDialog(context: context, barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: Text("Details Added Successfully"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("All the Details have been added Successfully")
              ],
          )
        ),
        actions: [
          FloatingActionButton(onPressed: () {
            Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      );
        }
      );
  }


  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedOption = "";
  final firstname = TextEditingController();
  final surname = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  String Id = randomAlphaNumeric(10);


  
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

  Future addUserwithDetails(String emailController, String firstname, String surname, int age, String selectedOption) async{
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.trim(),
        password: passwordController.text.trim(),
    );
    String Userid = userCredential.user!.uid;
    //String? Userid = await getUidFromEmail(email);

    await FirebaseFirestore.instance.collection('Users').doc((Userid)).set(
      {
      'email': emailController,
      'First Name': firstname,
      'Surname': surname,
      'Age': age,
      'Gender': selectedOption,
      'ID': Id,
      'UID': Userid,
      }
      
    );
  }

  Future addDetails() async{
    addUserwithDetails(
      emailController.text.trim(),
      firstname.text.trim(), 
      surname.text.trim(), 
      int.parse(age.text.trim()), 
      selectedOption.trim()
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
              size: 50,
            ),

            const SizedBox(
              height: 50,
              ),
        
            //welcome back you've been missed
            Text(
              "Create Your Account",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16),
              ),

            const SizedBox(
              height: 25,
              ),
            //username textfield
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
              height: 25,
              ),

            //First Name Textfield
              MyTextField(
              controller: firstname,
              hintText: "First Name",
              obscureText: false,
            ),

            const SizedBox(
              height: 25
              ),

            //Surname Textfield
              MyTextField(
              controller: surname,
              hintText: "Surname",
              obscureText: false,
            ),

            const SizedBox(
              height: 25
              ),

            //Age Textfield
              MyTextField(
              controller: age,
              hintText: "Age",
              obscureText: false,
            ),

            const SizedBox(
              height: 25
              ),

            //Gender field
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('Male',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                    ),
                  ),
                  leading: Radio(
                    value: "Male",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,

                    ),
                  ),
                  leading: Radio(
                    value: "Female",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ],
          ),

              const SizedBox(
                height: 25,
              ),


            //signin button
            MyButton(
              text: "Register",
              onTap: addDetails,
            ),

            const SizedBox(
              height: 25,
              ),

            //already have an account? login 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an Account?",
                style: TextStyle(
                  color: Colors.grey[700]
                ),
              ),
                const SizedBox(
                  width: 4
                  ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Login",
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