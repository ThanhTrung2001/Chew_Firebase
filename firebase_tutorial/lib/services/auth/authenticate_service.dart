import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final userFunction = UserFunction();
  final auth = FirebaseAuth.instance;
  final signIn = GoogleSignIn();

  getCurrentUser() async {
    return (await auth.currentUser);
  }

  //Check user loged in or not
  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<bool> googleSignIn() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    try {
      UserCredential result = await auth.signInWithCredential(credential);
      User? userCredential = result.user;
      if (result != null) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential!.uid)
            .get()
            .then((DocumentSnapshot document) {
          if (document.exists) {
          } else {
            userFunction.createNewUser(
              userCredential.uid,
              userCredential.displayName,
              userCredential.email,
              userCredential.photoURL,
              'unknown',
              false,
              '',
              [],
              [],
            );
          }
          currentUser.uid = userCredential.uid;
          // ignore: avoid_print
          print(document.data());
        });
        return true;
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> emailSignUp(
      String email, String password, String username) async {
    try {
      // ignore: unused_local_variable
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? userCredential = result.user;
      if (result.user != null) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential!.uid)
            .get()
            .then((DocumentSnapshot document) {
          if (document.exists) {
          } else {
            result.user!.updateDisplayName(username);
            userFunction.createNewUser(
              userCredential.uid,
              username,
              userCredential.email,
              'https://i.imgur.com/AOZhwOx.png',
              'unknown',
              false,
              '',
              [],
              [],
            );
          }
          // ignore: avoid_print
        });
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> emailSignIn(String email, String password) async {
    try {
      // ignore: unused_local_variable
      var result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        // ignore: avoid_print
        print('Wrong password provided for that user.');
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
    return false;
  }

  Future<void> requestResetPassword() async {}

  Future<void> resetPassword() async {}

  Future<void> updateInformation() async {}

  Future<void> logOut() async {
    auth.signOut();
  }

  Future<void> logOutGoogle() async {
    logOut();
    signIn.signOut();
  }
}
