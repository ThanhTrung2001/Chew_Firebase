import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:firebase_tutorial/services/auth/authenticate_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/dialogs/dialog_notification_template.dart';
import 'package:firebase_tutorial/views/components/dialogs/dialog_notification/dialog_success.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_password.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../components/dialogs/dialog_notification/dialog_error.dart';
import '../../components/dialogs/dialog_notification/dialog_warning.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserFunction userFunction = UserFunction();
    final authService = AuthenticationService();
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
                  height: 34.h,
                ),
                LoginInputTextField(controller: emailController, hint: 'Email'),
                SizedBox(
                  height: 20.h,
                ),
                PasswordTextField(controller: passController, hint: 'Password'),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 37.w),
                      child: GestureDetector(
                        onTap: () {
                          // AuthenticationService().logOut();
                          Navigator.of(context).pushNamed('/forgot');
                        },
                        child: const Text(
                          'Forgot?',
                          style: TextStyle(
                              color: Color(0xFF006BE9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                LoginFuncButton(
                    title: 'Login',
                    color: const Color(0xFF567BC3),
                    onPressed: () async {
                      if (emailController.text == "" ||
                          passController.text == "") {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogWarningNotification(
                                    title: 'Warning',
                                    content:
                                        "Please fill all of your information."));
                      } else {
                        bool i = await authService.emailSignIn(
                            emailController.text, passController.text);
                        print(i);
                        if (i == true) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DialogSuccessNotification(
                                      title: 'Success',
                                      content: "Waits for seconds and joins."));
                          Future.delayed(const Duration(seconds: 5), () {
                            Navigator.of(context).pushNamed('/');
                          });
                        } else if (i == false) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  DialogErrorNotification(
                                      title: 'Error',
                                      content: "Invalid email or password!"));
                        }
                      }
                    }),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Or',
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF818181)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                LoginFuncButton(
                    title: 'Signup',
                    color: const Color(0xFFB22759),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    }),
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  'Login with:',
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF818181)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ThirdPartyLoginButton(
                    //   imgLink: 'assets/images/Facebook.png',
                    //   onPressed: () {
                    //     // showDialog(
                    //     //     context: context,
                    //     //     builder: (context) => DialogSuccessNotification(
                    //     //         title: 'Successful!',
                    //     //         content: 'Direct to homepage.'));
                    //   },
                    // ),
                    // SizedBox(width: 21.w),
                    ThirdPartyLoginButton(
                      imgLink: 'assets/images/Google.png',
                      onPressed: () async {
                        await authService.googleSignIn();
                        Navigator.of(context).pushNamed('/');
                      },
                    ),
                  ],
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
                //                   email: emailController.text,
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
                //                     email: emailController.text,
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
