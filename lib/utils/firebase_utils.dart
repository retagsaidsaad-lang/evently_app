import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/model/event.dart';
import 'package:untitled1/model/my_user.dart';

class FirebaseUtils {

  static CollectionReference<MyUser> getUserCollection () {
   return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) =>
          MyUser.fromJson(snapshot.data()!),
      toFirestore: (myUser, options) =>
          myUser.toJson(),
    );
  }

  static Future<void> addUserInFireStore (MyUser myUser ){
    CollectionReference<MyUser> collectionRef = getUserCollection();
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.uId);
    return docRef.set(myUser);
 }

  static Future<MyUser?> readUserFromFireStore(String uId) async{
   var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static CollectionReference<Event> getEventCollection () {
     return FirebaseFirestore.instance.collection(Event.collectionName)
        .withConverter<Event>(
        fromFirestore: (snapshot, options) =>
        Event.fromJson(snapshot.data()!),
        toFirestore: ( event, options) =>
            event.toJson(),
    );
  }

  static Future<void> addEventInFireStore (Event event) {
   CollectionReference<Event> collectionRef = getEventCollection();
   DocumentReference<Event> docRef = collectionRef.doc();
   event.eventId = docRef.id;
   return docRef.set(event);
  }

  static Future<void> resetPassword (String email) async{
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  }

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



  static Future<void> updateEventInFireStore(Event event) {
    var collectionRef = getEventCollection();
    return collectionRef.doc(event.eventId).set(event);
  }



  static Future<void> deleteEventFromFirestore(String eventId) {
   var collectionRef = FirebaseFirestore.instance.collection(Event.collectionName);
    return collectionRef.doc(eventId).delete();
  }
}

