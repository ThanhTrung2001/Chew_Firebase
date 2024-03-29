import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/dialogs/dialog_notification/dialog_warning.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_password.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/user/user_service.dart';
import '../../components/dialogs/dialog_notification/dialog_error.dart';
import '../../components/dialogs/dialog_notification/dialog_success.dart';
import 'login.dart';

class ChangePassScreen extends ConsumerStatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePassScreenState();
}

class _ChangePassScreenState extends ConsumerState<ChangePassScreen> {
  final userFunction = UserFunction();
  final newPassController = TextEditingController();
  final retypeNewPassController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(top: 17.h, left: 10.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    'assets/icons/Back.png',
                    scale: 3,
                  )),
            ),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Logo
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 99.h,
                      ),
                      Image.asset(
                        'assets/images/Logo.png',
                        scale: 3,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Image.asset(
                        'assets/images/CHEW.png',
                        scale: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 95.h,
                ),
                Text(
                  'Reset Password:',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                SizedBox(
                  height: 24.h,
                ),
                PasswordTextField(
                    controller: newPassController, hint: 'New password'),
                SizedBox(
                  height: 20.h,
                ),
                PasswordTextField(
                    controller: retypeNewPassController,
                    hint: 'Retype new password'),
                SizedBox(
                  height: 24.h,
                ),
                LoginFuncButton(
                    title: 'Change',
                    color: const Color(0xFF285BA7),
                    onPressed: () async {
                      if (newPassController.text == "" ||
                          retypeNewPassController.text == "") {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogWarningNotification(
                                    title: "Warning",
                                    content: "Please fill your information!"));
                      } else if (newPassController.text !=
                          retypeNewPassController.text) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogErrorNotification(
                                    title: "Error",
                                    content: "Two field is not the same."));
                      } else {
                        final user = await FirebaseAuth.instance.currentUser;
                        await user
                            ?.updatePassword(newPassController.text)
                            .then((_) {
                          print("Successfully changed password!");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DialogSuccessNotification(
                                      title: "Success",
                                      content:
                                          "Congratulation. Redirect to Login page."));
                        }).catchError((error) {
                          print("Password can't be changed" + error.toString());
                          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                        });

                        Future.delayed(const Duration(seconds: 5), () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        });
                      }
                    }),
                SizedBox(
                  height: 50.h,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 1.5.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Copyright@ 2022 by Guineaa',
                      style: TextStyle(
                          fontSize: 18.sp, color: const Color(0xFFA4A4A4)),
                    ),
                    SizedBox(
                      height: 18.h,
                    )
                  ],
                )
                // Expanded(
                //   child: Column(

                //   )),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     ElevatedButton(
                //         onPressed: () async {
                //           UserCredential userCredential =
                //               await FirebaseAuth.instance.signInAnonymously();
                //           print('anonymous login');
                //           Navigator.of(context).pushNamed('/');
                //         },
                //         child: Text('Anonymous')),
                //     ElevatedButton(
                //       onPressed: () async {
                //         try {
                //           UserCredential userCredential = await FirebaseAuth
                //               .instance
                //               .signInWithEmailAndPassword(
                //                   email: newPassController.text,
                //                   password: passController.text);
                //           print('login successful');
                //           Navigator.of(context).pushNamed('/');
                //         } on FirebaseAuthException catch (e) {
                //           if (e.code == 'user-not-found') {
                //             print('No user found for that email.');
                //           } else if (e.code == 'wrong-password') {
                //             print('Wrong password provided for that user.');
                //           } else {}
                //         }
                //       },
                //       child: Text('Login'),
                //       style: ButtonStyle(),
                //     ),
                //     ElevatedButton(
                //         onPressed: () async {
                //           try {
                //             UserCredential userCredential = await FirebaseAuth
                //                 .instance
                //                 .createUserWithEmailAndPassword(
                //                     email: newPassController.text,
                //                     password: passController.text);
                //           } on FirebaseAuthException catch (e) {
                //             if (e.code == 'email-already-in-use') {
                //               print('conflict email!');
                //             }
                //           } catch (e) {
                //             print(e);
                //           }
                //         },
                //         child: Text('SignUp'))
                //   ],
                // ),
                // SizedBox(
                //   height: 50 * size.height / 896,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     ElevatedButton(
                //         onPressed: () {
                //           signInWithGoogle();
                //           print(user?.displayName);
                //         },
                //         child: Text('Google')),
                //   ],
                // ),
                // SizedBox(
                //   height: 50 * size.height / 896,
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       print(user?.email);
                //       logOutGoogle();
                //     },
                //     child: Text('logOutGoogle')),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
