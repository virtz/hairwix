import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://hairwix.herokuapp.com/api";

class UserService {
  static Future<String> login(String username, String password) async {
    String message;
    String token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://hairwix.herokuapp.com/api/auth/";
    final res = await Dio().post(url,
        data: {"username": username, "password": password},
        options: Options(headers: {"Content-type": "application/json"}));
    // .catchError((DioError e) => print(e));

    if (res.data['Message'] == 'Success') {
      message = res.data['Message'];
      token = res.headers['x-auth-token'][0];
      prefs.setString('token', token);
      prefs.setString('fullname', res.data['FullName']);
      prefs.setString('username', res.data['Username']);
      prefs.setString('email', res.data['Email']);
      prefs.setString('phone', res.data['Phone']);
      prefs.setString('password', res.data['Password']);
      prefs.setInt('id', res.data['ID']);
      prefs.setString('profilepic', res.data['ProfilePic']);

      // print(token);
    } else {
      print(res.data);
    }

    return message;
  }

  static Future<String> singup(
    String username,
    String password,
    // String usertype,
    String fullname,
    String phone,
    String email,
  ) async {
    String message;

    var url = "https://hairwix.herokuapp.com/api/users/";
    String usertype = "Customer";
    final res = await Dio().post(url,
        data: {
          "username": username,
          "usertype": usertype,
          "fullname": fullname,
          "password": password,
          "phone": phone,
          "email": email
        },
        options: Options(headers: {"Content-type": "application/json"}));

    if (res.data == 'Success') {
      message = res.data;
      print(res.data);
    } else {
      print(res.data);
    }

    return message;
  }

  static Future getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    var id = prefs.getInt('id');
    var url = "https://hairwix.herokuapp.com/api/users/$id";

    var res = await Dio()
        .get(url, options: Options(headers: {'x-auth-token': token}));
    print("method was called");
    print(res.data.toString());
    return res;
  }

  static Future<Response> updateProfile(
      username, password, usertype, fullname, phone, email, profilepic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    var id = prefs.getInt('id');

    var res = await Dio().put("https://hairwix.herokuapp.com/api/users/$id",
        data: {
          "username": username,
          "usertype": usertype,
          "fullname": fullname,
          "password": password,
          "phone": phone,
          "profilepic": profilepic,
          "email": email
        },
        options: Options(headers: {'x-auth-token': token}));
    // print(res.data);
    return res;
  }
}
