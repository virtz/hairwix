import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;

class ProductService {
  static Future getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    print(" from product service:$token");
  return await Dio()
        .get('https://hairwix.herokuapp.com/api/products',
            options: Options(headers: {'x-auth-token': token}))
        .catchError((e) => print(e));
  
  }
}

