import 'package:authapp/home_page_details.dart';
import 'package:authapp/language_detection_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLandingPage extends StatefulWidget {

  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {

 void SignOut() {
  FirebaseAuth.instance.signOut();
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
          Text(
            "Welcome Back!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            "What is it you wanna do today?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageDetails()));
              },
              child: Material(
                elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person, 
                                    size: 50, 
                                    color: Colors.white,
                                  ),
                        
                                  SizedBox(
                                    width: 20,
                                  ),
                        
                                  Text(
                                    "I want to edit Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap:() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LanguageDetectionPage())
                );
              },
            child: Material(
              elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "lib/images/langlogo.png",
                                  height: 55,
                                  ),
                      
                                const SizedBox(
                                  width: 10,
                                ),
                      
                                Text(
                                  "I want to detect language",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
        //signout button
        TextButton(
          onPressed: SignOut,
          child: Text(
              "Sign out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: Colors.black
                )
              )
            )
           ),
          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}