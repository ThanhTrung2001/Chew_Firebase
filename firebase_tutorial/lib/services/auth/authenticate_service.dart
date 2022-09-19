import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final auth = FirebaseAuth.instance;
  final signIn = GoogleSignIn();

  //Check ủe loged in or not
  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<void> googleSignIn() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    try{
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e);
    }
    
  }

  Future<void> emailSignUp(String email, String password) async {
    try {
      // ignore: unused_local_variable
      var user =
          auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> emailSignIn(String email, String password) async {
    try {
      // ignore: unused_local_variable
      var user =
          auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ignore: avoid_print
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> requestResetPassword() async {}

  Future<void> resetPassword() async {}

  Future<void> updateInformation() async {}

  Future<void> logOut() async {
    auth.signOut();
    signIn.signOut();
  }
}
