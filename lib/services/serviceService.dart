import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;

class ServicesService {
  static Future getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    return await Dio().get(
      'https://hairwix.herokuapp.com/api/services',
      options:Options(headers: {'x-auth-token': token},)
    ).catchError((e)=>print(e));
  }
}
