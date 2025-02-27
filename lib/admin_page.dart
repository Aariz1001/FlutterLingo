import 'package:authapp/add_user_with_details.dart';
import 'package:authapp/language_detection_page.dart';
import 'package:authapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;


  Stream? UserStream;

  getontheload() async{
    UserStream = FirebaseFirestore.instance.collection("Users").snapshots();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  String selectedOption = '';

  final firstname = TextEditingController();
  final surname = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();

  Widget AllUserDetails() {
    return StreamBuilder(
      stream: UserStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds=snapshot.data.docs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                      Text(
                        (ds["First Name"]+" "+ds["Surname"]),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          firstname.text = ds["First Name"];
                          surname.text = ds["Surname"];
                          age.text = ds["Age"].toString();
                          selectedOption = ds["Gender"];
                          EditUserDetails(ds["UID"]);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20
                      ),
                      GestureDetector(
                        onTap: () async{
                          await DatabaseMethods().deleteUserDetail(ds["UID"]);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                          ),
                      ),
                    ]
                  ),
                      Text(
                        ds["Age"].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        ds["Gender"],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  )
                ),
              ),
            );
          }
        ) : Container();
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
                "Admin",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
            ),
          ),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
                Icons.logout,
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
            const SizedBox(
              width: 10
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageDetectionPage()));
              },
              child: Icon(
                Icons.language
              ),
            ),
            const SizedBox(
              width: 10
            )
          ],
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: AllUserDetails()),
            FloatingActionButton.extended(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserWithDetailsPage()));
              },
              isExtended: true,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
  Future EditUserDetails(String Userid) => showDialog(
    context: context, builder: (context)=> AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel),
                  ),
                ]
              ),
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
          
              //update button
              TextButton(
                onPressed: () {
          Map<String, dynamic>updateInfo={
            "First Name": firstname.text.trim(),
            "Surname": surname.text.trim(),
            "Age": int.parse(age.text.trim()),
            "Gender": selectedOption.trim(),
            "UID": Userid,
          };
          FirebaseFirestore.instance.collection("Users").doc(Userid).set(updateInfo).then((value){
            Navigator.pop(context);
          });
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
            ],
          ),
        ),
      ),
    )
  );
}