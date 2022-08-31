import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ForgotScreen extends ConsumerStatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends ConsumerState<ForgotScreen> {
  final emailController = TextEditingController();
  final googleSignIn = GoogleSignIn();
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
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/icons/Back.png', scale: 3,)),
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
                Text('Type your registered email:', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                SizedBox(
                  height: 24.h,
                ),
                LoginInputTextField(controller: emailController, hint: 'Email'),
                SizedBox(
                  height: 24.h,
                ),
                LoginFuncButton(title: 'Send Code', color: const Color(0xFF285BA7), onPressed: (){
                  Navigator.of(context).pushNamed('/verify');
                }),
                const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 1.5.h,
                      ),
                      SizedBox(height: 20.h,),
                      Text('Copyright@ 2022 by Guineaa', style: TextStyle(fontSize: 18.sp, color: const Color(0xFFA4A4A4)),),
                      SizedBox(height: 18.h,)
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


