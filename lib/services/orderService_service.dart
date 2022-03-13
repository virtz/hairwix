import 'package:dio/dio.dart';
// import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;

class OrderServices {
  static Future orderService(String description, int id) async {
    String referenceId, orderby;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    referenceId = randomAlphaNumeric(12);
    token = prefs.get('token');
    orderby = prefs.get('username');

    var url = "https://hairwix.herokuapp.com/api/order_services/";
    final res = await Dio().post(url,
        data: {
          "service_id": id.toString(),
          "order_description": description,
          "reference_id": referenceId,
          "order_by": orderby
        },
        options: Options(headers: {'x-auth-token': token}));
    print(res.data);
    if (res.data != null) {
      print(res.data);
    } else {
      print(res.data);
    }
    return res.data;
  }

  static Future getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    var orderby = prefs.get('username');
    var url = "https://hairwix.herokuapp.com/api/order_services/$orderby";
    return await Dio()
        .get(url,
            // queryParameters: {"orderby": orderby},
            options: Options(headers: {'x-auth-token': token}))
        .catchError((e) => print(e));
  }
}
