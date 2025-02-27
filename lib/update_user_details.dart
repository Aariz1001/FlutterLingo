import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({super.key});



  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {



  // document IDs
  List<String> DocIDs = [];

  // get DocIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection("Users").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        DocIDs.add(document.reference.id);
      }),
    );
  }

void _showconfirmDialog(BuildContext context) {
    showDialog(context: context, barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: Text("Details Updated Successfully"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("All the Details have been updated Successfully")
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

  String selectedOption = '';

  final user = FirebaseAuth.instance.currentUser!;
  final firstname = TextEditingController();
  final surname = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  String Id = "";


  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
  }



  Future updateUserDetails(String firstname, String surname, int age, String selectedOption) async{
    await FirebaseFirestore.instance.collection('Users').doc().update(
      {
      'First Name': firstname,
      'Surname': surname,
      'Age': age,
      'Gender': selectedOption,
      }
    );
    _showconfirmDialog(context);
  }

  Future updateDetails() async{
    updateUserDetails(
      firstname.text.trim(), surname.text.trim(), int.parse(age.text.trim()), selectedOption.trim());
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 151, 151),
        elevation: 0,
        actions: [
          IconButton(onPressed: signUserOut, 
          icon: const Icon(
            Icons.logout
            )
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
          "Update User Details",
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
          hintText: "Enter your First name",
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
          hintText: "Enter your Last name",
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
          hintText: "Enter your age",
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
      onPressed: () {
        Map<String, dynamic>updateInfo={
          "First Name": firstname.text.trim(),
          "Surname": surname.text.trim(),
          "Age": int.parse(age.text.trim()),
          "Gender": selectedOption.trim(),
          "ID": Id,
        };
      },
      child: Text(
          "Update",
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