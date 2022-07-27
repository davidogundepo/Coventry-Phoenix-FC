import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/management_body.dart';
import '../notifier/management_body_notifier.dart';

getManagementBody(ManagementBodyNotifier managementBodyNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('ManagementBody')
      .orderBy('id')
      .get();

  List<ManagementBody> managementBodyList = [];

  for (var document in snapshot.docs) {
    ManagementBody managementBody = ManagementBody.fromMap(document.data() as Map<String, dynamic>);
    managementBodyList.add(managementBody);
  }

  managementBodyNotifier.managementBodyList = managementBodyList;
}
