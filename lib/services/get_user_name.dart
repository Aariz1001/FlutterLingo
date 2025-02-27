import 'package:authapp/update_user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {

    // get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = 
        snapshot.data!.data() as Map<String, dynamic>;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['First Name']+"\n"+data['Surname'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => UpdateUserDetails()
                      )
                    );
                  },
                  icon: Icon(Icons.edit,
                  color: Colors.white,
                    )
                  )
                ],
              ),
              Text(
                data['Age'].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
              Text(
                data['Gender'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ],
          );
      }
      return Text('Loading...');
      }
      )
    );
  }
}