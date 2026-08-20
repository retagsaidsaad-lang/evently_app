import 'package:flutter/cupertino.dart';
import 'package:untitled1/model/my_user.dart';

class UserProvider extends ChangeNotifier{
  MyUser? currentUser ;


  void upDateUser (MyUser newUser) {
    currentUser = newUser ;
    notifyListeners();
  }
}