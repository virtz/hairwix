

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hairmarket/models/user.dart';
import 'package:hairmarket/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User user;
  var users = List<User>();
  var message;
  var errorMessage;
  bool loading = false;
  bool isLoggedin = false;

  login(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setLoading(true);
    try {
      String message =
          await UserService.login(username, password).then((value) {
        return value;
      });
      setLoading(false);
      print(message);
      setMessage(message);
      setIsloggedIn(true);
      print(isLoggedin);
      prefs.setBool('isLoggedin', isLoggedin);
    } on DioError catch (e) {
      setLoading(false);
      print(e);

      setErrorMessage(e.response.toString());
    }
  }

  signup(username, usertype, fullname, password, phone, email) async {
    setLoading(true);
    try {
      String message =
          await UserService.singup(username, password, fullname, phone, email)
              .then((value) {
        return value;
      });
      print(message);
      setLoading(false);
      setMessage(message);
    } on DioError catch (e) {
      setLoading(false);
      print(e);
      setErrorMessage(e.response.toString());
    }
  }

  getCurrentUser() async {
    try {
      await UserService.getCurrentUser().then((response) {
        Iterable list = response.data;
        users = list.map((e) => User.fromJson(e)).toList();
        // return user;
      });
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    }
  }

  updateProfile(
      username, password, usertype, fullname, phone, email, profilepic) async {
    try {
      setLoading(true);
      await UserService.updateProfile(
              username, password, usertype, fullname, phone, email,profilepic)
          .then((value) {
        // print(value);
        if (value != null) {
          setLoading(false);
          setMessage("Profile updated successfully");
        }
      });
      print(message);
      setLoading(false);
    } on DioError catch (e) {
      setLoading(false);
      setErrorMessage(e.response.toString());
    }
  }

  void setIsloggedIn(value) {
    isLoggedin = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setMessage(value) {
    message = value;
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setErrorMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getErrorMessage() {
    return errorMessage;
  }
}
