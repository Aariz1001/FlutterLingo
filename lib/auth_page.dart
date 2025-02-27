import 'package:authapp/components/admin_landingpage.dart';
import 'package:authapp/components/my_landingpage.dart';
import 'package:authapp/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            User user = snapshot.data!;
            if(user.email == "admin@gmail.com" && user.uid == "MTZrQpZMsndEpO0YS4ewW54j32o1") {
              return AdminLandingPage();
            }
            else{
              return MyLandingPage();
            }
          }

          //user is not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}