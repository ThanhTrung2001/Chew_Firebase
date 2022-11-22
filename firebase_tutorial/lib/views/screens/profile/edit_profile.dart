import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

import '../../../config/export.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final userFunction = UserFunction();
  final nameController = TextEditingController();
  final desController = TextEditingController();
  bool changePass = false;
  final passwordController = TextEditingController();
  final retypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          "Edit",
          style: AppTextStyle.appbarTitle,
        ),
        leading: Padding(
          padding: EdgeInsets.only(top: 17.h, left: 10.w),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: AppIcon.back),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            LoginInputTextField(controller: nameController, hint: name),
            SizedBox(
              height: 10,
            ),
            LoginInputTextField(controller: desController, hint: description),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                    value: changePass,
                    onChanged: (value) {
                      setState(() {
                        changePass = value;
                      });
                    }),
                SizedBox(
                  width: 2,
                ),
                Text('Change password'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LoginInputTextField(
                controller: passwordController, hint: "Password"),
            SizedBox(
              height: 10,
            ),
            LoginInputTextField(
                controller: retypeController, hint: "Retype Password"),
            SizedBox(
              height: 10,
            ),
            LoginMiniButton(
                title: 'Save',
                color: Colors.green,
                onPressed: () async {
                  if (nameController.text == "" || desController.text == "") {
                    print('Must fill all the field!');
                  } else {
                    if (changePass == true) {
                      if (passwordController.text == "" ||
                          retypeController.text == "") {
                        print('Must fill all the field!');
                      } else if (passwordController.text !=
                          retypeController.text) {
                        print("Password & Retype aren't match!");
                      } else {
                        final user = await FirebaseAuth.instance.currentUser;
                        await userFunction.updateUser(
                            user?.uid, nameController.text, desController.text);
                        await user
                            ?.updatePassword(passwordController.text)
                            .then((_) {
                          print("Successfully changed password!");
                        }).catchError((error) {
                          print("Password can't be changed" + error.toString());
                          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                        });
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }
                    } else {
                      final user = await FirebaseAuth.instance.currentUser;
                      userFunction.updateUser(
                          user?.uid, nameController.text, desController.text);
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
