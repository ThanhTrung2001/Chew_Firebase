import 'package:firebase_tutorial/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier(): super(UserModel('', '', '', '', ''));
  
  

}