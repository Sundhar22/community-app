import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microsoft/service/firebase_auth_service.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference communityCollection =
      FirebaseFirestore.instance.collection("communityCollection");

// saving the data to database
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'userName': fullName,
      'email': email,
      'groups': [],
      'profilePic': "",
      'uid': uid,
    });
  }

  // getting  the snapchat

  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

// getting userGroup dAta
  Future userGroup() async {
    return userCollection.doc(uid).snapshots();
  }
  //  creating group

  Future createGroup(
      String name, String id, String groupName, String groupDescription) async {
    DocumentReference groupDocumentReference = await communityCollection.add({
      'groupName': groupName,
      'groupDescription': groupDescription,
      "groupIcon": '',
      'admin': '${id}_$name',
      "members": [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
    });
    // updating members
    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$name']),
      'groupId': groupDocumentReference.id
    });

    //
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  Future getChats(String groupId) async {
    return communityCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = communityCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  getGroupMembers(groupId) async {
    return communityCollection.doc(groupId).snapshots();
  }

  Future getGroupDescription(String groupId) async {
    DocumentReference documentReference = communityCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot['groupDescription'];
  }

  searchByName(String groupName) {
    return communityCollection.where("groupName", isEqualTo: groupName).get();
  }

  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  Future groupJoinExit(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference communityDocumentReference =
        communityCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List groups = await documentSnapshot['groups'];

    if (groups.contains('${groupId}_$groupName')) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(['${groupId}_$groupName'])
      });
      await communityDocumentReference.update({
        'members': FieldValue.arrayRemove(['${uid}_$userName'])
      });
    } else {
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
      });
      await communityDocumentReference.update({
        'members': FieldValue.arrayUnion(['${uid}_$userName'])
      });
    }
  }

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    communityCollection
        .doc(groupId)
        .collection('messages')
        .add(chatMessageData);
    communityCollection.doc(groupId).update({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentMessageTime': chatMessageData['time'].toString()
    });
  }
}
