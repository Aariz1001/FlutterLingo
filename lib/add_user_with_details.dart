import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class AddUserWithDetailsPage extends StatefulWidget {
  const AddUserWithDetailsPage({super.key});

  @override
  State<AddUserWithDetailsPage> createState() => _AddUserWithDetailsPageState();
}

class _AddUserWithDetailsPageState extends State<AddUserWithDetailsPage> {

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

Future<String?> getUidFromEmail(String email) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  if (snapshot.docs.isNotEmpty) {
    DocumentSnapshot userDoc = snapshot.docs.first;
    return userDoc['UID']; 
  }

  return null;
}
  String selectedOption = "";
  final user = FirebaseAuth.instance.currentUser!;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final surname = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  String Id = randomAlphaNumeric(10);


  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }



  Future addUserwithDetails(String email, String firstname, String surname, int age, String selectedOption) async{
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.text.trim(),
    );
    String Userid = userCredential.user!.uid;
    //String? Userid = await getUidFromEmail(email);

    await FirebaseFirestore.instance.collection('Users').doc((Userid)).set(
      {
      'email': email,
      'First Name': firstname,
      'Surname': surname,
      'Age': age,
      'Gender': selectedOption,
      'ID': Id,
      'UID': Userid,
      }
      
    );
    _showconfirmDialog(context);
  }

  Future addDetails() async{
    addUserwithDetails(
      email.text.trim(),
      firstname.text.trim(), 
      surname.text.trim(), 
      int.parse(age.text.trim()), 
      selectedOption.trim()
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 151, 151),
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: signUserOut, 
              icon: const Icon(
                Icons.logout
                )
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
          "Add User Details",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 36,
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      const SizedBox(
        height: 30,
      ),

      //email textfield
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: email,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Enter email",
          hintStyle: TextStyle(
            color: Colors.grey[500]
          ),
        ),
      ),
    ),

    const SizedBox(
      height: 10,
    ),

      //Password textfield
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: password,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Enter Password",
          hintStyle: TextStyle(
            color: Colors.grey[500]
          ),
        ),
      ),
    ),

    const SizedBox(
      height: 10,
    ),

      //firstname textfield
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: firstname,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Enter First name",
          hintStyle: TextStyle(
            color: Colors.grey[500]
          ),
        ),
      ),
    ),

    const SizedBox(
      height: 10,
    ),

    //surname textfield
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: surname,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Enter Last name",
          hintStyle: TextStyle(
            color: Colors.grey[500]
          ),
        ),
      ),
    ),

    const SizedBox(
      height: 10,
    ),

    //surname textfield
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: age,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Enter age",
          hintStyle: TextStyle(
            color: Colors.grey[500]
          ),
        ),
      ),
    ),

    const SizedBox(
      height: 10,
    ),

    //gender field
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
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
    ),


    const SizedBox(
      height: 25,
    ),

    //save button
    TextButton(
      onPressed: addDetails,
      child: Text(
          "Save",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Colors.blue
            )
          )
        )
       ),
      )
              ]
            ),
          )
        )
      )
    );
  }
}
