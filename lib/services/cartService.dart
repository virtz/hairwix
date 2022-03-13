import 'package:dio/dio.dart';
import 'package:hairmarket/models/product_.dart';
import 'package:hive/hive.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;

class CartService {
  static addToCart(Product_ product) async {
    await Hive.openBox<Product_>('cart');
    final cartBox = Hive.box<Product_>('cart');
    cartBox.add(product);
    print(product.name);
  }

  
  static Future<String> orderCart(totalPrice, totalQuantity) async {
    String referenceId, orderby;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    referenceId = randomAlphaNumeric(12);
    prefs.setString('referenceId', referenceId);
    token = prefs.get('token');
    orderby = prefs.get('username');

    var url = "https://hairwix.herokuapp.com/api/order_cart/";
    final res = await Dio().post(url,
        data: {
          "referenceId": referenceId,
          "totalPrice": totalPrice,
          "totalQuantity": totalQuantity,
          "order_by": orderby
        },
        options: Options(headers: {'x-auth-token': token}));
    if (res.data != null) {
      print(res.data);
    }
    return res.data;
  }

  static Future orderProduct(List products) async {
    String referenceId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    referenceId =    prefs.get('referenceId');
    token = prefs.get('token');
    var url = "https://hairwix.herokuapp.com/api/order_product/products";
    products.forEach((product) async {
      product.referenceId = referenceId;
    });
    for (var i = 0; i < products.length; i++) {
      Product_ product = products[i];
      print(product.name);
      final res = await Dio()
          .post(
            url,
            data: {
              "referenceId": product.referenceId,
              "productId": product.id,
              "quantity": product.quantity
            },
            options: Options(headers: {'x-auth-token': token}),
          )
          .catchError((e) => print(e));
      print(res.data);
    }
  }
}
