import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:w8/models/brew.dart';
import 'package:w8/models/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');


  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({   
      'sugars': sugars,
      'name': name,
      'strength': strength,
    }); //creates new doc if it doesnt exist
  }

  //brew list from snapsjot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data()['name'],
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0);
    }).toList();
  }

//userData from snapshot
CustomUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {

  return CustomUserData(
    uid: uid,
    name: snapshot.data()['name'],
    sugars: snapshot.data()['sugars'],
    strength: snapshot.data()['strength']
  );
}


//get brews strean
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //get user doc strean

  Stream<CustomUserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}