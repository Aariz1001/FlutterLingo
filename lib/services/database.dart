import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future AddUserDetails(
    Map<String, dynamic> employeeInfoMap, String Userid
  ) async {
    return await FirebaseFirestore
    .instance.collection('Users')
    .doc(Userid)
    .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserDetails() async {
    return await FirebaseFirestore
    .instance.collection('Users')
    .snapshots();
  }

  Future updateUserDetail(String Userid, Map<String, dynamic> updateInfo) async{
    return await FirebaseFirestore
    .instance.collection('Users')
    .doc(Userid)
    .update(updateInfo);
  }
  Future deleteUserDetail(String Userid) async{
    return
    await FirebaseFirestore
    .instance.collection('Users')
    .doc(Userid)
    .delete();
  }
}