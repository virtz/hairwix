import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hairmarket/models/product.dart';
import 'package:hairmarket/services/productService.dart';

class ProductsProvider with ChangeNotifier {
  var products = List<Product>();
  var message;
  var errorMessage;
  bool loading = false;

  getProducts() async {
    try {
      // setLoading(true);
      await ProductService.getProducts().then((response) {
        Iterable list = response.data;
        products = list.map((model) => Product.fromJson(model)).toList();
        // setLoading(false);
        return products;
      });
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    }
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
