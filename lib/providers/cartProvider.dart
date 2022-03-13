import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hairmarket/models/product_.dart';

import 'package:hairmarket/services/cartService.dart';
import 'package:hive/hive.dart';

class CartProvider with ChangeNotifier {
  var message;
  var errorMessage;
  bool loading = false;
  List _products = [];
  List get products => _products;
  var total;
  var existingItem;

  addToCart(product) async {
    setLoading(true);
    try {
      await Hive.openBox<Product_>('cart');
      final cartBox = Hive.box<Product_>('cart');
      cartBox.add(product);
      print(product.name);

      _products = cartBox.values.toList();

      setLoading(false);
      notifyListeners();
    } on HiveError catch (e) {
      setLoading(false);
      setErrorMessage(e.message);
    }
  }

  checkIfExists(Product_ product) {
    existingItem = products.firstWhere(
      (element) => element.id == product.id,
    );
    notifyListeners();
  }

  getCart() async {
    final cartBox = await Hive.openBox<Product_>('cart');
    _products = cartBox.values.toList();
    // print(_products);
    return _products;
  }

  addAndUpdateData(int index, Product_ product) {
    product.quantity = product.quantity + 1;
    product.totalPrice = product.price.toDouble() * product.quantity;
    print(product.quantity);
    notifyListeners();
    final cartBox = Hive.box('cart');
    cartBox.putAt(index, product);
  }

  subAndUpdateData(int index, Product_ product) {
    if (product.quantity <= 1) {
      product.quantity = product.quantity = 1;
    } else {
      product.quantity = product.quantity - 1;
    }
    product.totalPrice = product.price.toDouble() * product.quantity;
    notifyListeners();
    // print(product.quantity);
    final cartBox = Hive.box('cart');
    cartBox.putAt(index, product);
  }

  deleteProduct(int index) async {
    final cartBox = Hive.box<Product_>('cart');
    cartBox.delete(index);
    // cartBox.deleteFromDisk();

    notifyListeners();
  }

  updateTotalPice() {
    var cartList = products;
    var totalList = cartList.map((e) => e.totalPrice);
    total = totalList.isEmpty
        ? 0.0
        : totalList.reduce((value, element) => value + element);
    // notifyListeners();
  }

  orderCart(totalPrice, totalQuantity) async {
    setLoading(true);
    try {
      message =
          await CartService.orderCart(totalPrice, totalQuantity).then((value) {
        return value;
      });
      setLoading(false);
      if (message != null) {
        setMessage(message);
        // print(totalPrice);
      }
    } on DioError catch (e) {
      setLoading(false);
      setErrorMessage(e.response.toString());
    }
  }

  orderProductInCart(List products) async {
    setLoading(true);
    try {
      await CartService.orderProduct(products);

      setMessage('Success');
      setLoading(false);
      print(products);
      final cartBox = Hive.box<Product_>('cart');
      cartBox.deleteFromDisk();
      // return value;

    } on DioError catch (e) {
      setLoading(false);
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
